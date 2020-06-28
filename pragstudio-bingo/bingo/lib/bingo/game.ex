defmodule Bingo.Game do
  @moduledoc false

  alias Bingo.{Buzzwords, Game, Square, BingoChecker, Player}

  defstruct [
    name: "",
    squares: nil,
    winner: nil,
    scores: %{},
  ]

  def new(size) when is_integer(size) do
    buzzwords = Buzzwords.read_buzzwords()
    Game.new(buzzwords, size)
  end

  def new(buzzwords, size) do
    squares =
      buzzwords
      |> Enum.shuffle
      |> Enum.take(size * size)
      |> Enum.map(&Square.new/1)
      |> Enum.chunk_every(size)

    %Game{squares: squares}
  end

  def mark(game = %Game{winner: %Player{}}, _, _), do: game

  def mark(game, phrase, player) do
    game
    |> update_squares(phrase, player)
    |> update_scores
    |> update_winner
  end

  defp update_squares(%Game{} = game, phrase, player) do
    squares =
      game.squares
      |> Enum.concat
      |> Enum.map(&Square.update_phrase(&1, phrase, player))
      |> Enum.chunk_every(length(game.squares))

    %{game | squares: squares}
  end

  defp update_scores(game) do
    scores =
      game.squares
      |> Enum.concat
      |> Enum.reduce(%{}, fn square, acc ->
        cond do
          is_struct(square.marked_by) ->
            player_name = square.marked_by.name

            previous_score = Map.get(acc, player_name)
            previous_score = if previous_score == nil, do: 0, else: previous_score

            Map.put(acc, player_name, (square.points + previous_score))
          true -> acc
        end
      end)
    %{game | scores: scores}
  end

  defp update_winner(game) do
    player = BingoChecker.bingo?(game.squares)
    cond do
      is_struct(player) ->
        %{game | winner: player}
      true ->
        game
    end
  end

end
