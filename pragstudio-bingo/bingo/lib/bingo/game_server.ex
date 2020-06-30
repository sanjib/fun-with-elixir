defmodule Bingo.GameServer do
  @moduledoc false

  use GenServer

  @timeout :timer.minutes(60)

  #_________________
  # Client interface

  def start_link(game_name, size) do
    IO.puts "Starting Game Server #{game_name}..."
    GenServer.start_link(__MODULE__, {game_name, size}, name: via_tuple(game_name))
  end

  def summary(game_name) do
    GenServer.call via_tuple(game_name), :summary
  end

  def mark(game_name, phrase, player) do
    GenServer.call via_tuple(game_name), {:mark, phrase, player}
  end

  def display(game_name) do
    GenServer.call via_tuple(game_name), :display
  end

  #_________________
  # Server callbacks

  def init({game_name, size}) do
    buzzwords = Bingo.BuzzwordCache.get_buzzwords()
    game = Bingo.Game.new(buzzwords, size)
    {:ok, %{game | name: game_name}, @timeout}
  end

  def handle_call(:summary, _from, game) do
    {:reply, summarize(game), game, @timeout}
  end

  def handle_call({:mark, phrase, player}, _from, game) do
    new_game = Bingo.Game.mark(game, phrase, player)
    {:reply, summarize(new_game), new_game, @timeout}
  end

  def handle_call(:display, _from, game) do
    IO.puts "\n** Game Summary: #{game.name} **"
    Bingo.GameDisplay.display(game)
    {:reply, :ok, game, @timeout}
  end

  def handle_info(:timeout, game) do
    IO.puts "--> :timeout called"
    {:stop, {:shutdown, :timeout}, game}
  end

  def terminate({:shutdown, :timeout}, _game) do
    IO.puts "--> terminate({:shutdown, :timeout}) called"
    :ok
  end

  def terminate(_reason, _game) do
    IO.puts "--> terminate(_reason, _game) called"
    :ok
  end

  #________________
  # Helpers

  def via_tuple(game_name) do
    {
      :via,
      Registry,
      {Bingo.GameRegistry, game_name}
    }
  end

  defp summarize(game) do
    %{
      scores: game.scores,
      squares: game.squares,
      winner: game.winner,
    }
  end

  def game_pid(game_name) do
    game_name |> via_tuple |> GenServer.whereis
  end

end
