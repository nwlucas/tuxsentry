defmodule Facts.Disk do
  require Facts.Disk.Constants
  import Facts.Utils
  alias Facts.Disk.Constants, as: DC

  def partitions(all \\ false) do
    filename = host_etc("mtab")
    lines = read_file(filename) |> String.split("\n")
  end

  defp get_file_systems() do

  end
end
