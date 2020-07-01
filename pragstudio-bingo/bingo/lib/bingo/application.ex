defmodule Bingo.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {Registry, keys: :unique, name: Bingo.GameRegistry},
      {Bingo.BuzzwordCache, ["buzz_test.csv", :timer.minutes(5)]},
      Bingo.GameSupervisor,
    ]

    opts = [strategy: :one_for_one, name: Bingo.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
