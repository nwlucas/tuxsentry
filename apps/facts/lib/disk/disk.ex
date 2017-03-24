defmodule Facts.Disk do
  require Facts.Disk.Constants
  import Facts.Utils
  alias Facts.Disk.Constants, as: DC

  @doc """
  `Facts.Disk.partitions/1` reads the disk information from the host, cleans up the data a bit and returns a list
  with the info. Depending on the value of all it will return all disks if true, or only physical disks if false.
  """
  def partitions(all \\ false) do
    filename = host_etc("mtab")
    lines = read_file(filename)
            |> String.split("\n")
            |> Enum.map(& String.split(&1))
            |> Enum.map(& Enum.take(&1, 4))
            |> Enum.filter(& !Enum.empty?(&1))

    fs = get_file_systems()

  end

  @spec get_file_systems :: list
  defp get_file_systems() do
    filename = host_proc("filesystems")
    lines = read_file(filename)
            |> String.split("\n")
            |> Enum.filter(& !(String.length(&1) == 0))
            |> Enum.map(& String.trim_leading(&1, "nodev"))
            |> Enum.map(& String.trim_leading(&1, "\t"))
    lines
  end

#  defp get_fs_type() do
#
#  end
end
