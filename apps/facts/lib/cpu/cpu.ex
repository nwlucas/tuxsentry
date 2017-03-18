defmodule Facts.CPU do
    import Facts.Utils

    def info do
    filename = host_proc("cpuinfo")
    file = File.open!(filename)
    data = IO.binstream(file, :line)
       |> Enum.map(fn(x) -> Regex.replace(~r/(\t|\n)+/, x, "") end)
       |> Enum.map(fn(x) -> sanitize_data(x) end)
       |> parse_list


    IO.puts "Length #{length(data)}"
    IO.inspect data

    File.close(file)
    end

    def sanitize_data("" = data) when is_binary(data), do: ""
    def sanitize_data(data) when is_binary(data) do
        [k,v] = String.split(data, ":", trim: true)
        Map.put(%{}, k, v )
    end

    def parse_list(item, m \\ %{})
    def parse_list([], m ), do: m
    def parse_list(["" = _item | tail], m), do: parse_list(tail, m)
    def parse_list([item | tail], m) when is_map(item) do
        case m do
          %{} -> parse_list(tail, )
        end
    end
end
