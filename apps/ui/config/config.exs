use Mix.Config

config :ui,
  namespace: TuxSentry.UI

config :ui, TuxSentry.UI.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "OAvEr5VlyTxrJSnL7dLowh93pMLD0W7KklhYlsY+3BqMdF+AXKxRD71YvNcaHSCY",
  render_errors: [view: TuxSentry.UI.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: TuxSentry.UI.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

import_config "#{Mix.env}.exs"
