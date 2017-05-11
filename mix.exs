defmodule TuxSentry.Mixfile do
  @moduledoc false
  use Mix.Project

  def project do
    [apps_path: "apps",
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

  defp deps do
    [
      {:distillery, "~> 1.0"},
      {:excoveralls, "~> 0.6", only: :test}
    ]
  end
end
