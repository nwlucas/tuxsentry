defmodule TuxSentry.UI.Application do
  @moduledoc """
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(TuxSentry.UI.Web.Endpoint, []),
    ]

    opts = [strategy: :one_for_one, name: TuxSentry.UI.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
