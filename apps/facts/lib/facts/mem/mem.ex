defmodule Facts.Mem do
  @moduledoc """
  """
  alias Facts.Mem.{VirtualMemStat,SwapMemStat}
  import Facts.Utils
  require Logger

  @byte_multiplier 1024

  def memory_info() do
    filename = host_proc("meminfo")
    contents = read_file(filename, sane: true)

    mem_info = Enum.into( Enum.map(contents, & b2kl(&1)), %{})

    %{ v_mem: virtual_memory(mem_info), s_mem: swap_memory(mem_info) }
  end

  @spec virtual_memory(map) :: %Facts.Mem.VirtualMemStat{}
  defp virtual_memory(data) do
    avail = determine_avail_mem(data)

    %{ %VirtualMemStat{} |
      total: data.memtotal,
      available: avail,
      used: data.memtotal - avail,
      used_percent: (data.memtotal - avail) / data.memtotal * 100,
      free: data.memfree,
      active: data.active,
      inactive: data.inactive,
      buffers: data.buffers,
      cached: data.cached,
      writeback: data.writeback,
      dirty: data.dirty,
      writeback_tmp: data.writebacktmp,
      shared: data.shmem,
      slab: data.slab,
      page_tables: data.pagetables,
      swap_cached: data.swapcached
    }
  end

  @spec swap_memory(map) :: %Facts.Mem.SwapMemStat{}
  defp swap_memory(data) do
    filename = host_proc("vmstat")
    contents = read_file(filename, sane: true)
      |> Enum.map(& String.split(&1))
      |> Enum.map(fn [k,v] -> { String.to_atom(k), String.to_integer(v)} end)
      |> Enum.into(%{})

    used = data.swaptotal - data.swapfree
    sm = %{ %SwapMemStat{} |
      total: data.swaptotal,
      free: data.swapfree,
      used: used
    }

    if (data.swaptotal != 0), do: Map.put(sm, :used_percent, (used / data.swaptotal * 100))
    if Map.has_key?(contents, :pswpin), do: Map.put(sm, :sin, contents.pswpin * 4 * @byte_multiplier)
    if Map.has_key?(contents, :pswpout), do: Map.put(sm, :sout, contents.pswpout * 4 * @byte_multiplier)
    sm
  end

  # function merely splits the string by the identifier and returns a keyword list
  defp b2kl(item) do
    s = String.split(item, ":", parts: 2)
        |> Enum.map(& String.trim_leading(&1))
        |> Enum.map(& String.downcase(&1))

    k = Enum.fetch!(s, 0)
    v = Enum.fetch!(s, 1) |> String.split |> Enum.fetch!(0)

    { String.to_atom(k), String.to_integer(v) * @byte_multiplier }
  end

  defp determine_avail_mem(data) do
    case Map.has_key?(data, :memavailable) do
      false -> data.memfree + data.buffers + data.cached
      true -> data.memavailable
    end
  end
end
