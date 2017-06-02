defmodule TuxSentry.Core.Application do
  @moduledoc """
  """
  alias TuxSentry.Core
  use Application

  @ets_cache_name :cache_tbl

  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    ets_opts = [
      :named_table,
      :public,
      :set,
      {:read_concurrency, true},
      {:write_concurrency, true}
    ]

    ets = :ets.new(@ets_cache_name, ets_opts)

    children = [
      worker(TuxSentry.Core.Cache, [ets, @ets_cache_name, []]),
      worker(TuxSentry.Core.Settings, [[]])
    ]

    opts = [strategy: :one_for_one, name: TuxSentry.Core.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
