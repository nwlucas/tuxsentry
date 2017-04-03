defmodule Facts.Disk do
  @moduledoc """
  """
  alias Facts.Disk.Constants, as: DC
  import Facts.Utils
  require Facts.Disk.Constants
  require Logger

  @doc """
  `Facts.Disk.partitions/1` reads the disk information from the host, cleans up the data a bit and returns a list
  with the info. Depending on the value of all it will return all disks if true, or only physical disks if false.
  """
  @spec partitions(boolean) :: list(%Facts.Disk.PartitionStat{})
  def partitions(all \\ false) do

    try do
      mtab = read_mtab()
      fs = get_file_systems()

      case all do
        true -> fs = filter_file_systems(fs, mtab)
      end

      {:ok, {mtab, fs}}
    rescue
      e -> Logger.error "Error occured while attempting to gather partitions facts: " <> e
      {:error, e}
    end

  end

  @spec read_mtab :: list(list(String.t))
  defp read_mtab() do
    filename = host_etc("mtab")
    lines = read_file(filename)
            |> String.split("\n")
            |> Enum.map(& String.split(&1))
            |> Enum.map(& Enum.take(&1, 4))
            |> Enum.filter(& !Enum.empty?(&1))
    lines
  end

  @spec generate_list(data :: list, file_systems :: list, options :: list) :: list(%Facts.Disk.PartitionStat{})
  defp generate_list(raw, fs, opts) do

  end

  @spec get_file_systems :: list(String.t)
  defp get_file_systems() do
    filename = host_proc("filesystems")
    lines = read_file(filename)
            |> String.split("\n")
            |> Enum.filter(& !(String.length(&1) == 0))
            |> Enum.map(& String.trim_leading(&1, "nodev"))
            |> Enum.map(& String.trim_leading(&1, "\t"))
    lines
  end

#  @spec get_fs_type :: listy
#  defp get_fs_type() do
#
#  end
end
