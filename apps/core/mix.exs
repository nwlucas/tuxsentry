defmodule TuxSentry.Core.Mixfile do
  @moduledoc false
  use Mix.Project

  def project do
    [
      app: :core,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.4",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        "coveralls": :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  def application do
    [mod: {TuxSentry.Core.Application, []},
      extra_applications: [:logger, :runtime_tools]]
  end

  defp deps do
    [
      {:exfacts, git: "https://github.com/nwlucas/exfacts"},
      {:ui, in_umbrella: true},
      {:timex, "~> 3.0"}
    ]
  end
end
