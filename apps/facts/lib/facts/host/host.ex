defmodule Facts.Host do
  @moduledoc """
  """
  import Facts.Utils, except: [read_file: 1]
  require Logger

  def info do
    b = boot_time()
    { platform, version } = platform_info()

    %Facts.Host.InfoStat{
      hostname: hostname(),
      uptime: up_time(b),
      bootime: b,
      procs: counts(),
      platform: platform,
      platform_family: get_family(platform),
      platform_version: version,
      kernel_version: kernel_version()
    }
  end

  # This function is used as a stub to call the real function.
  # This is only here as a convenience since the uderlying function was re-written to be better but not all calls to it
  # have been updated to match the new fucntionality. Also the default behaviour has been kept in a way to as to not
  # break the existing codebase, but this may change as the default may flip and should only do so once all calls to it
  # have been updated.

  defp read_file(filename) do
    Facts.Utils.read_file(filename, sane: true)
  end

  @spec counts :: integer
  defp counts do
   case System.cmd "nproc", [] do
     {k, 0} ->
        String.to_integer(String.replace(k, "\n", ""))
     {_, _} -> raise "Unable to determine the CPU count"
   end
  end

  @spec hostname :: binary
  defp hostname do
   case System.cmd "hostname", [] do
     {k, 0} ->
        String.replace(k, "\n", "")
     {_, _} ->
        Logger.error "Unable to determine the Hostname"
        "Undetermined"
   end
  end

  @spec boot_time :: integer
  defp boot_time do
    filename = host_proc("stat")

    try do
      btime = read_file(filename)
              |> Enum.filter(& String.starts_with?(&1, "btime"))
              |> Enum.flat_map(& String.split(&1))
              |> Enum.fetch!(1)
              |> String.to_integer()

      btime
    rescue
      e -> Logger.error "Error occured: " <> e
      0
    end

  end

  @spec up_time(integer) :: integer
  defp up_time(b), do: System.system_time(:millisecond) - b

  @spec platform_info :: { binary, binary }
  defp platform_info() do
    try do
      lsb = get_lsb()

      cond do
        File.exists?(host_etc("oracle-release")) ->
          platform = "oracle"
          contents = read_file(host_etc("oracle-release"))
          version = get_version(contents, type: "redhat")
          {platform, version}
        File.exists?(host_etc("enterprise-release")) ->
          platform = "oracle"
          contents = read_file(host_etc("enterprise-release"))
          version = get_version(contents, type: "redhat")
          {platform, version}
        File.exists?(host_etc("debian_version")) ->
          case lsb.id do
            "Ubuntu" ->
              platform = "ubuntu"
              version = lsb.release
              {platform, version}
            "LinuxMint"  ->
              platform = "linuxmint"
              version = lsb.release
              {platform, version}
            _ ->
              if File.exists?("/usr/bin/raspi-config") do
                platform = "raspbian"
              else
                platform = "debian"
              end

              contents = read_file(host_etc("debian_version"))
          end
        File.exists?(host_etc("redhat-release")) ->
          contents = Fact.Utils.read_file(host_etc("redhat-release"), sane: false)
          version = get_version(contents, type: "redhat")
          platform = get_platform(contents, type: "redhat")
          {platform, version}
        File.exists?(host_etc("system-release")) ->
          contents = Fact.Utils.read_file(host_etc("system-release"), sane: false)
          version = get_version(contents, type: "redhat")
          platform = get_platform(contents, type: "redhat")
          {platform, version}
        File.exists?(host_etc("gentoo-release")) ->
          platform = "gentoo"
          contents = Fact.Utils.read_file(host_etc("gentoo-release"), sane: false)
          version = get_version(contents, type: "redhat")
          {platform, version}
        File.exists?(host_etc("SuSE-release")) ->
          contents = Fact.Utils.read_file(host_etc("SuSE-release"), sane: false)
          version = get_version(contents, type: "suse")
          platform = get_platform(contents, type: "suse")
          {platform, version}
        File.exists?(host_etc("arch-release")) ->
          platform = "arch"
          version = lsb.release
          {platform, version}
        File.exists?(host_etc("alpine-release")) ->
          platform = "alpine"
          contents = read_file(host_etc("alpine-release"))
          version = hd(contents)
          {platform, version}
        File.exists?(host_etc("os-release")) ->
          [ID: platform, VERSION_ID: version] = get_os_release()
          {platform, version}
        lsb.id == "ScienticficSL" -> { "scientific", lsb.release }
        lsb.id != "" -> { String.downcase(lsb.id), lsb.release }
      end
    rescue
        e -> Logger.error "Error occured while capturing Platform Information" <> e
        {"",""}
    end
  end

  @spec get_os_release() :: list
  defp get_os_release() do
    filename = host_etc("os-release")

    try do
      rel = read_file(filename)
            |> Enum.map(& String.replace(&1, "\"", ""))
            |> Enum.map(& String.split(&1, "="))
            |> Enum.map(fn (x) -> {String.to_atom(hd(x)), Enum.fetch!(tl(x), 0)} end )
      rel
    rescue
      e -> Logger.error "Error occured: " <> e
      []
    end
  end

  @spec get_lsb() :: %Facts.Host.LSB{}
  defp get_lsb() do
    lsb = cond do
      File.exists?(host_etc("lsb-release")) -> get_lsb_release()
      File.exists?("/usr/bin/lsb_release") -> get_lsb_from_bin()
    end

    lsb
  end

  @spec get_lsb_release() :: %Facts.Host.LSB{}
  defp get_lsb_release() do
    lines = read_file(host_etc("lsb-release"))
            |> Enum.map(& String.replace(&1, "\"", ""))
            |> Enum.map(& String.split(&1, "="))
            |> Enum.map(fn (x) -> {
                  String.to_atom(String.trim_leading(hd(x), "DISTRIB_")),
                  Enum.fetch!(tl(x), 0)
                } end )

    %Facts.Host.LSB{
      id: lines[:ID],
      release: lines[:RELEASE],
      codename: lines[:CODENAME],
      description: lines[:DESCRIPTION]
    }
  end

  # Todo. This function has only been fleshed out and I already know there are validation issues with it.
  # WIP needs to be properly written to handle cleanup of spaces and cases.
  defp get_lsb_from_bin() do
    { lines, _} = System.cmd "/usr/bin/lsb_release", []

    case lines do
      "" -> %Facts.Host.LSB{ id: "", release: "", codename: "", description: "" }
      _ ->
        ret = String.split(lines, "\n")
              |> Enum.filter(& !(String.length(&1) == 0))
              |> Enum.map(& String.replace(&1, "\"", ""))
              |> Enum.map(& String.split(&1, ":"))
              |> Enum.map(fn (x) -> {
                    String.to_atom(hd(x)), Enum.fetch!(tl(x), 0)
                  } end )

        %Facts.Host.LSB{
          id: ret[:distributor_id],
          release: ret[:release],
          codename: ret[:codename],
          description: ret[:description]
        }
    end
  end

  @spec kernel_version :: binary
  defp kernel_version() do
    filename = host_proc("/sys/kernel/osrelease")
    contents = if File.exists?(filename), do: hd(read_file(filename)), else: ""

    contents
  end

  defp virtualization() do
      xen_file = host_proc("xen")
      modules_file = host_proc("modules")
      cpu_file = host_proc("cpuinfo")
  end

  @spec get_version(binary, list) :: binary
  defp get_version(data, opts \\ []) do
    redhat_regex = ~r/release (?<version>\d[\d.]*)/
    suse_v_regex = ~r/VERSION = (?<version>[\d.]+)/
    suse_p_regex = ~r/PATCHLEVEL = (?<patch>[\d.]+)/

    data = String.downcase(data)

    filtered = case opts.type do
      "redhat" -> Regex.named_captures(redhat_regex, data)
      "suse" ->
        s = Regex.named_captures(suse_v_regex, data)
        if is_nil(s), do: Regex.named_captures(suse_p_regex, data)
    end

    if Map.has_key?(filtered, "version"), do: Map.fetch!(filtered, "version"), else: Map.fetch!(filtered, "patch")
  end

  @spec get_platform(binary, list) :: binary
  defp get_platform(data, opts \\ []) do
    platform = case opts.type do
      "redhat" ->
        "redhat_platform"
      "suse" ->
        "suse_platform"
    end

  end

  @spec get_family(binary) :: binary
  defp get_family(p) do
    case p do
      dist when dist in ["debian", "ubuntu", "linuxmint", "raspbian"] -> "debian"
      dist when dist in ["oracle", "centos", "redhat", "scientific", "enterpriseenterprise", "amazon", "xenserver", "cloudlinux", "ibm_powerkvm"] -> "rhel"
      dist when dist in ["fedora"] -> "fedora"
      dist when dist in ["suse", "opensuse"] -> "suse"
      dist when dist in ["gentoo"] -> "gentoo"
      dist when dist in ["slackware"] -> "slackware"
      dist when dist in ["arch"] -> "arch"
      dist when dist in ["exherbo"] -> "exherbo"
      dist when dist in ["alpine"] -> "alpine"
      dist when dist in ["coreos"] -> "coreos"
      _ -> "Undetermined"
    end
  end
end
