defmodule Bingo.MixProject do
  use Mix.Project

  def project do
    [
      app: :bingo,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Bingo.Application, []}
    ]
  end

  defp deps do
    []
  end
end
