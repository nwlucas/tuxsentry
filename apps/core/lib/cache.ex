defmodule TuxSentry.Core.Cache do
  @moduledoc """
  Stores all information collected in an ETS table. It operates that tables
  as a cache of sorts. Also `TuxSentry.Core` performs other functions that
  expires the cache, launcing tasks to do the removal on timed periods.

  Archival of other bits of data used for calculation or representation are
  also stored here and can be easily provided to the UI.
  """
  use GenServer

  ## Client API

  def start_link(table, cache_table_name, opts) do
    defaults = [name: __MODULE__]
    options = Keyword.merge(defaults, opts)
    GenServer.start_link(__MODULE__, {table, cache_table_name}, options)
  end

  def add_data(key, data), do: GenServer.cast(__MODULE__, {:set, key, data})

  ## Server callbacks

  def handle_cast({:set, key, data}, state) when is_atom(key) do
    {table, table_name} = state
    table = :ets.insert(table_name, {key, data})
    {:noreply, {table, table_name}}
  end

  def init({tbl, tbl_name}) do
    {:ok, {tbl, tbl_name}}
  end
end
