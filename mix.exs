defmodule Climate.MixProject do
  use Mix.Project

  def project do
    [
      app: :climate,
      version: "0.1.0",
      elixir: "~> 1.12-dev",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: [main_module: Climate.Cli]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.7"},
      {:erlsom, "~> 1.5"},
      {:ex_doc, "~> 0.22.6"},
      {:earmark, "~> 1.4"},
      {:emojix, "~> 0.2.0"},
      {:mock, "~> 0.3.5"},
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
