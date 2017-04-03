use Mix.Config

config :logger, compile_time_purge_level: :info
import_config "../apps/*/config/config.exs"
