defmodule TuxSentry.Mixfile do
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
      ],
     dialyzer: [
      plt_add_deps: :transitive,
      paths: [
        "_build/dev/lib/facts/ebin",
        "_build/dev/lib/core/ebin",
        "_build/dev/lib/ui/ebin",
      ]
     ]
    ]
  end

  defp deps do
    [
      {:distillery, "~> 1.0"},
      {:dialyxir, "~> 0.5.0", only: [:dev]},
      {:excoveralls, "~> 0.6", only: :test}
    ]
  end
end
