defmodule TuxSentry.Mixfile do
  use Mix.Project

  def project do
    [apps_path: "apps",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
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
    [{:dialyxir, "~> 0.5.0", only: [:dev]}]
  end
end
