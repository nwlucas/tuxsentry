defmodule Facts.Host do
  @moduledoc """
  """
  import Facts.Utils
  require Logger

  def info do
    IO.inspect boot_time(), label: "Boot time"
    IO.inspect up_time(), label: "Up time"
    IO.inspect get_os_release(), label: "OS Release"
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
    end

  end

  @spec up_time() :: integer
  defp up_time(), do: System.system_time(:millisecond) - boot_time()

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
    rescue
      e -> Logger.error "Error occured: " <> e
    end
  end
end
