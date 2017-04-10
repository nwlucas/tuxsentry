defmodule Facts.Host do
  @moduledoc """
  """
  import Facts.Utils
  require Logger

  def info do
    b = boot_time()

    %Facts.Host.InfoStat{
      hostname: hostname(),
      uptime: up_time(b),
      bootime: b,
      procs: counts()
    }
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
     {_, _} -> raise "Unable to determine the Hostname"
   end
  end

  @spec boot_time :: integer
  defp boot_time do
    filename = host_proc("stat")

    try do
      btime = read_file(filename)
              |> String.split("\n")
              |> Enum.filter(& !(String.length(&1) == 0))
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

  @spec get_os_release() :: list
  defp get_os_release() do
    filename = host_etc("os-release")

    try do
      rel = read_file(filename)
            |> String.split("\n")
            |> Enum.filter(& !(String.length(&1) == 0))
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
    cond do
      File.exists?(host_etc("lsb-release")) -> get_lsb_release()
      File.exists?("/usr/bin/lsb_release") -> get_lsb_from_bin()
    end
  end

  @spec get_lsb_release() :: %Facts.Host.LSB{}
  defp get_lsb_release() do
    lines = read_file(host_etc("lsb-release"))
            |> String.split("\n")
            |> Enum.filter(& !(String.length(&1) == 0))
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

  defp virtualization() do
      xen_file = host_proc("xen")
      modules_file = host_proc("modules")
      cpu_file = host_proc("cpuinfo")
  end
end
