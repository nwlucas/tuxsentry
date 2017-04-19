defmodule Facts.Load do
  @moduledoc """
  """
  alias Facts.Load.{AvgStat,MiscStat}
  import Facts.Utils
  require Logger

  def avg() do
   filename = host_proc("loadavg")
   contents = read_file(filename, sane: true)

   loads = hd(contents)
            |> String.splitter(" ", trim: true)
            |> Enum.take(3)
            |> Enum.map(& String.to_float(&1))

    %AvgStat{
      load1: Enum.fetch!(loads, 0),
      load5: Enum.fetch!(loads, 1),
      load15: Enum.fetch!(loads, 2)
    }

  end

  def misc() do
   filename = host_proc("stat")
   contents = read_file(filename, sane: false)

   running_regex = ~r/procs_running (?<running>[\d]+)/
   blocked_regex = ~r/procs_blocked (?<blocked>[\d]+)/
   ctxt_regex = ~r/ctxt (?<ctxt>[\d]+)/

   results = %{}
    |> Map.merge(Regex.named_captures(running_regex, contents))
    |> Map.merge(Regex.named_captures(blocked_regex, contents))
    |> Map.merge(Regex.named_captures(ctxt_regex, contents))

   %MiscStat{
     procs_running: String.to_integer(Map.fetch!(results, "running")),
     procs_blocked: String.to_integer(Map.fetch!(results, "blocked")),
     ctxt: String.to_integer(Map.fetch!(results, "ctxt"))
   }
  end
end
