defmodule Bingo.GameServer do
  @moduledoc false

  use GenServer

  @timeout :timer.hours(1)

  #_________________
  # Client interface

  def start_link(game_name, size) do
    IO.puts "Starting Game Server #{game_name}..."
    GenServer.start_link(__MODULE__, {game_name, size}, name: game_name)
  end

  def summary(game_name) do
    GenServer.call game_name, :summary
  end

  def mark(game_name, phrase, player) do
    GenServer.call game_name, {:mark, phrase, player}
  end

  #_________________
  # Server callbacks

  def init({game_name, size}) do
    game = Bingo.Game.new(size)
    {:ok, %{game | name: game_name}}
  end

  def handle_call(:summary, _from, game) do
    IO.puts ""
    IO.puts "** Game Summary: #{game.name} **"
    Bingo.GameDisplay.display(game)
    {:reply, nil, game}
  end

  def handle_call({:mark, phrase, player}, _from, game) do
    game = Bingo.Game.mark(game, phrase, player)
    {:reply, nil, game}
  end

end
