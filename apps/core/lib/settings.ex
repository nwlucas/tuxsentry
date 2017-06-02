defmodule TuxSentry.Core.Settings do
  @moduledoc """
  """
  use GenServer

  @table_name :settings_tbl
  ## Client API

  @doc """
  Starts the settings registry.
  """
  def start_link(opts) do
    defaults = [name: __MODULE__]
    options = Keyword.merge(defaults, opts)

    init_opts = [name: @table_name, args: []]
    GenServer.start_link(__MODULE__, init_opts, options)
  end

  ## Server Callbacks
  def init([{:name, table_name}, {:args, ets_args}] = opts) do
    ets_defs = [
      :set,
      :named_table,
      :protected
    ]

    ets_opts = ets_defs ++ ets_args
    :ets.new(table_name, ets_opts)

    prime_settings(table_name)

    {:ok, %{table_name: table_name}}
  end

  defp prime_settings(table) do
    :ets.insert(table, {:refresh_time, 600})
    :ets.insert(table, {:flush_to_disk, false})
    :ets.insert(table, {:flush_time, 3600})
  end
end
