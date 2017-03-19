defmodule Facts.Utils do
  @moduledoc """

  `Facts.Utils` contains common logic that is used mostly internally by other modules.

  """

  def host_proc, do: Path.absname("/proc")
  def host_proc(combine_with)  when is_binary(combine_with) do
    if is_nil(System.get_env("HOST_PROC")) do
      Path.join("/proc", combine_with)
    else
      Path.join(System.get_env("HOST_PROC"), combine_with)
    end
  end

  def host_sys, do: Path.absname("/sys")
  def host_sys(combine_with)  when is_binary(combine_with) do
    if is_nil(System.get_env("HOST_SYS")) do
      Path.join("/sys", combine_with)
    else
      Path.join(System.get_env("HOST_SYS"), combine_with)
    end
  end

  def host_etc, do: Path.absname("/etc")
  def host_etc(combine_with)  when is_binary(combine_with) do
    if is_nil(System.get_env("HOST_ETC")) do
      Path.join("/etc", combine_with)
    else
      Path.join(System.get_env("HOST_ETC"), combine_with)
    end
  end

  def read_file(filename) do
    with {:ok, file} <- File.open(filename),
      data = IO.binread(file, :all),
      :ok <- File.close(file),
      do: data
  end

  def sanitize_data("" = data) when is_binary(data), do: ""
  def sanitize_data("\n" = data) when is_binary(data), do: ""
  def sanitize_data(data) when is_binary(data) do
    [k,v] = Regex.replace(~r/(\t|\n)+/, data, "")
      |> String.split(":", trim: true)
    Map.put(%{}, k, v )
  end

  def normalize_with_underscore(item) when is_map(item) do
    k = Map.keys(item)
      |> Enum.map(fn(x) -> String.trim(x) |> String.downcase |> String.replace(~r/\s+/,"_") end)
      |> hd

    Map.new([{k, hd(Map.values(item))}])
  end

  def normalize_with_underscore(item) when is_tuple(item) do
    k = elem(item, 0)
      |> String.trim
      |> String.downcase
      |> String.replace(~r/\s+/,"_")

    {k, elem(item,1)}
  end

  def normalize_with_underscore("" = item) when is_binary(item), do: %{}

  def delete_all(list, value) do
    Enum.filter(list, & &1 !== value)
  end

end
