defmodule Servy.MixProject do
  use Mix.Project

  def project do
    [
      app: :servy,
      description: "Humble HTTP Server",
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Servy, []},
      env: [port: 4000]
    ]
  end

  defp deps do
    [
      {:poison, "~> 3.1"},
      {:earmark, "~> 1.4"},
      {:httpoison, "~> 1.6"}
    ]
  end
end
