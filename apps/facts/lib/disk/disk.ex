defmodule Facts.Disk do
  require Facts.Disk.Constants
  import Facts.Utils
  alias Facts.Disk.Constants, as: DC

  def partitions(all \\ false) do
    filename = host_etc("mtab")
  end

  defp get_file_systems() do
    
  end
end
