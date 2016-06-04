defmodule Jot.Mixfile do
  use Mix.Project

  @version "0.0.1"

  def project do
    [
      app: :jot,
      version: @version,
      elixir: "~> 1.0",
      deps: deps,
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      consolidate_protocols: Mix.env != :test,

      name: "Jot",
      source_url: "https://github.com/lpil/jot",
      description: "Lightweight HTML templating",
      files: ~w(lib src mix.exs README* LICENCE*),
      package: [
        maintainers: ["Louis Pilfold"],
        licenses: ["MIT"],
        links: %{ "GitHub" => "https://github.com/lpil/jot" },
      ],
    ]
  end

  def application do
    [applications: []]
  end

  defp deps do
    [
      # Automatic test runner
      {:mix_test_watch, github: "lpil/mix-test.watch", only: [:dev, :test]},

      # Markdown processor
      {:earmark, "~> 0.2", only: :dev},
      # Documentation generator
      {:ex_doc, "~> 0.11", only: :dev},
    ]
  end
end
