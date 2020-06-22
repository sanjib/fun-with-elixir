defmodule Slurpie.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    IO.puts "Starting the Slurpie Application..."
    children = [
      # Starts a worker by calling: Slurpie.Worker.start_link(arg)
      # {Slurpie.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Slurpie.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
