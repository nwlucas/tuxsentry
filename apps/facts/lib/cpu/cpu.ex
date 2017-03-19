defmodule Facts.CPU do
  @moduledoc """

  `Facts.CPU` handles all logic with regards to collecting metrics on the CPUs of the host.

  """
  import Facts.Utils
  alias Facts.CPU.{InfoStat, TimeStat}

  def count do

  end

  def info do
  filename = host_proc("cpuinfo")
  file = File.open!(filename)
  data = IO.binstream(file, :line)
    |> Enum.map(& sanitize_data(&1) )
    |> Enum.map(& normalize_with_underscore(&1) )
    |> delete_all(%{})
    |> Enum.chunk(27)
    |> Enum.map(& flatten_info(&1))
  File.close(file)
  data
  end

  defp flatten_info(list, m \\ %{})
  defp flatten_info([], m), do: m
  defp flatten_info(list, m), do: flatten_info(tl(list), Map.merge(m, hd(list)))

  defp populate_info([head | tail]) do

  end

#    defp populate_time(data) when is_list(data) do
#
#    end
end
