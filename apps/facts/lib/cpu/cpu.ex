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
    |> Enum.map(& finish_info(&1))
    |> Enum.map(& populate_info(&1))
  File.close(file)
  data
  end

  defp flatten_info(list, m \\ %{})
  defp flatten_info([], m), do: m
  defp flatten_info(list, m), do: flatten_info(tl(list), Map.merge(m, hd(list)))

  defp finish_info(data) when is_map(data) do
    for {key, val} <- data, into: %{} do
      {String.to_atom(String.trim_leading(key, "cpu_")),  String.trim(val)}
    end
  end

  defp populate_info(data) when is_map(data) do
    cd =  for {key, val} <- data, into: %{} do
            case key do
              :processor -> {:cpu, String.to_integer(val)}
              :flags -> {key, String.split(val)}
              :cores -> {key, String.to_integer(val)}
              :stepping -> {key, String.to_integer(val)}
              :mhz -> {key, (String.to_float(val) / 1000)}
              :cache_size ->
                v = hd(String.split(val))
                {key, String.to_integer(v)}
              _ -> {key, val}
            end
          end
    struct(InfoStat, cd)
  end

#    defp populate_time(data) when is_list(data) do
#
#    end
end
