defmodule Facts.Utils do

  def host_proc(combine_with)  when is_binary(combine_with) do
    if is_nil(System.get_env("HOST_PROC")) do
      Path.join("/proc", combine_with)
    else
      Path.join(System.get_env("HOST_PROC"), combine_with)
    end
  end

  def host_proc, do: Path.absname("/proc")

  def host_sys(combine_with)  when is_binary(combine_with) do
    if is_nil(System.get_env("HOST_SYS")) do
      Path.join("/sys", combine_with)
    else
      Path.join(System.get_env("HOST_SYS"), combine_with)
    end
  end

  def host_sys, do: Path.absname("/sys")

  def host_etc(combine_with)  when is_binary(combine_with) do
    if is_nil(System.get_env("HOST_ETC")) do
      Path.join("/etc", combine_with)
    else
      Path.join(System.get_env("HOST_ETC"), combine_with)
    end
  end

  def host_etc, do: Path.absname("/etc")

  def read_file(filename) do
    with {:ok, file} <- File.open(filename),
      data = IO.binread(file, :all),
      :ok <- File.close(file),
      do: {:ok, data}
  end

end
