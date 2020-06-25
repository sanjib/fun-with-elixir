defmodule Bingo.GameDisplay do
  @moduledoc false

  alias Bingo.{Player}

  def display(game) do
    trailing_pad_size =
      game.squares
      |> Enum.concat
      |> length_longest_phrase

    lines =
      game.squares
      |> Enum.map(&display_line(&1, trailing_pad_size))
      |> Enum.join("\n")

    bingo_winner = bingo_winner(game.winner)

    IO.puts """

    #{lines}

    Scores: #{inspect game.scores}

    #{bingo_winner}
    """
  end

  def length_longest_phrase(squares) do
    len_score_placeholder = 7 # space ( 3 digits ) space

    Enum.reduce(squares, 0, fn square, len_longest ->
      len_current = String.length(square.phrase) + len_score_placeholder
      cond do
        len_current > len_longest -> len_current
        true -> len_longest
      end
    end)
  end

  #______________________________________
  # bingo_winner

  defp bingo_winner(%Player{} = player) do
    ":-) Bingo! Winner is: #{player.name}"
  end

  defp bingo_winner(nil) do
    ":-( No bingo (yet)"
  end

  #_______________________________________
  # display_line

  defp display_line(squares, trailing_pad_size) do
    squares
    |> Enum.map(fn square -> String.pad_trailing("#{square.phrase} (#{square.points})", trailing_pad_size) end)
    |> Enum.join("| ")
  end

end
