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

  # _________________
  # API
  def child_spec(args) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, args},
      restart: :transient,
    }
  end

  #_________________
  # Server callbacks

  def init({game_name, size}) do
    buzzwords = Bingo.BuzzwordCache.get_buzzwords()

    game =
      case :ets.lookup(:bingo_games_table, game_name) do
        [] ->
          game = Bingo.Game.new(buzzwords, size)
          :ets.insert(:bingo_games_table, {game_name, game})
          game
        [{^game_name, game}] ->
          game
      end

    {:ok, %{game | name: game_name}, @timeout}
  end

  def handle_call(:summary, _from, game) do
    {:reply, summarize(game), game, @timeout}
  end

  def handle_call({:mark, phrase, player}, _from, game) do
    new_game = Bingo.Game.mark(game, phrase, player)

    # :ets.insert(:bingo_games_table, {new_game.name, new_game})
    :ets.insert(:bingo_games_table, {get_game_name(), new_game})

    {:reply, summarize(new_game), new_game, @timeout}
  end

  def handle_call(:display, _from, game) do
    IO.puts "\n** Game Summary: #{game.name} **"
    Bingo.GameDisplay.display(game)
    {:reply, :ok, game, @timeout}
  end

  def handle_info(:timeout, game) do
    #IO.puts "--> :timeout called"
    {:stop, {:shutdown, :timeout}, game}
  end

  def terminate({:shutdown, :timeout}, _game) do
    game_name = get_game_name()
    IO.puts "--> timeout -> terminated -> #{game_name}"
    :ets.delete(:bingo_games_table, game_name)
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
#    squares =
#      game.squares
#      |> Enum.map(fn row ->
#        Enum.map(row, fn square ->
#          Map.from_struct(square)
#        end)
#      end)

    squares = for row <- game.squares do
      Enum.map(row, fn square ->
        Map.from_struct(%{square | marked_by: marked_by(square.marked_by)})
      end)
    end

    %{
      scores: game.scores,
      squares: squares,
      winner: game.winner,
    }
  end

  defp marked_by(%Bingo.Player{} = player), do: Map.from_struct(player)
  defp marked_by(nil), do: nil

  def game_pid(game_name) do
    game_name |> via_tuple |> GenServer.whereis
  end

  defp get_game_name() do
    Registry.keys(Bingo.GameRegistry, self()) |> List.first
  end
end
