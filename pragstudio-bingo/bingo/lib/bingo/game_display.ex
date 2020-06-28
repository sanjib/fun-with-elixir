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

    #{border_line(length(game.squares), trailing_pad_size, :top)}
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
    ":-) Bingo! Winner is: #{player.name}."
  end

  defp bingo_winner(nil) do
    ":-( No bingo (yet)!"
  end

  #_______________________________________
  # display_line

  defp display_line(squares, trailing_pad_size) do

    line1 =
      squares
      |> Enum.map(fn square ->
        String.pad_trailing("#{square.phrase} (#{square.points})", trailing_pad_size)
      end)
      |> Enum.join("| ")

    line2 =
      squares
      |> Enum.map(fn square ->
        marked_by(square.marked_by, trailing_pad_size)
      end)
      |> Enum.join("| ")

    border_line = border_line(length(squares), trailing_pad_size, :bottom)

    line1 <> "\n" <> line2 <> "\n" <> border_line
  end

  defp border_line(square_number, trailing_pad_size, location) do
    location_map = [top: "__", bottom: "|_"]
    border = String.duplicate("_", trailing_pad_size)
    1..square_number
    |> Enum.map(fn _ ->
      String.pad_trailing(border, trailing_pad_size)
    end)
    |> Enum.join(location_map[location])
  end

  defp marked_by(nil, trailing_pad_size), do: String.pad_trailing("by: _", trailing_pad_size)
  defp marked_by(%Player{} = player, trailing_pad_size), do: String.pad_trailing("by: #{player.name}", trailing_pad_size)

end
