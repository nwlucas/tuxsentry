defmodule TuxSentry.Core do
  @moduledoc """
  """
  alias TuxSentry.Core.Cache
  use ExFacts, Timex

  @doc """
  Queries each subsystem for data and caches the answers.
  """
  def init do
    call_time = Timex.now

    with {:ok, host_facts} <- ExHost.host_info(),
      {:ok, cpu_facts} <- ExCPU.cpu_info(),
      {:ok, disk_facts} <- ExDisk.partitions(),
      {:ok, lavg_facts} <- ExLoad.avg(),
      {:ok, lmisc_facts} <- ExLoad.misc(),
      {:ok, mem_facts} <- ExMem.memory_info(),
      {:ok, if_facts} <- ExNet.interfaces()
    do
      Cache.add_data :host, %{data: host_facts, c_at: call_time}
      Cache.add_data :cpus,  %{data: cpu_facts, c_at: call_time}
      Cache.add_data :disks,  %{data: disk_facts, c_at: call_time}
      Cache.add_data :load_avg,  %{data: lavg_facts, c_at: call_time}
      Cache.add_data :load_misc,  %{data: lmisc_facts, c_at: call_time}
      Cache.add_data :memory,  %{data: mem_facts, c_at: call_time}
      Cache.add_data :interfaces,  %{data: if_facts, c_at: call_time}
    end
  end
end
