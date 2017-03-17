defmodule Facts.CPU do

  import Facts.Utils

  def info do
    host_proc("cpuinfo")
    |> read_file()
    |> process_info()

  end

  def process_info(a) when is_tuple(a) do
    {_, data} = a

    Regex.replace(~r/\t+/, data, "")
    |> String.split("\n", trim: true)
    |> Enum.map( fn(item) ->String.split(item, ":", trim: true) end)
    |> generate_struct
  end

  def generate_struct(data) when is_list(data) do

  end
end


