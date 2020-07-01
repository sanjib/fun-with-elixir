defmodule Bingo.GameSupervisor do
  @moduledoc false

  use DynamicSupervisor

  @name __MODULE__

  def start_link(_args) do
    IO.puts "Starting Game Supervisor..."
    DynamicSupervisor.start_link(__MODULE__, :ok, name: @name)
  end

  def init(:ok) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_game(game_name, size) do
#    child_spec = %{
#      id: Bingo.GameServer,
#      start: {Bingo.GameServer, :start_link, [game_name, size]},
#      restart: :transient,
#    }
#    DynamicSupervisor.start_child(__MODULE__, child_spec)
    DynamicSupervisor.start_child(__MODULE__, {Bingo.GameServer, [game_name, size]})
  end

  def game_names do
    DynamicSupervisor.which_children(__MODULE__)
    |> Enum.map(fn {_, game_pid, _, _} ->
      Registry.keys(Bingo.GameRegistry, game_pid) |> List.first()
    end)
    |> Enum.sort()
  end

  def stop_game(game_name) do
    game_pid = Bingo.GameServer.game_pid(game_name)
    DynamicSupervisor.terminate_child(__MODULE__, game_pid)
  end
end
