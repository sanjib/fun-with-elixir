defmodule Bingo.BingoChecker do
  @moduledoc "Determines if a bingo has been achieved by examining squares"

  def bingo?(squares) do
    size = length(squares)
    indexes =
      [row_list(size), col_list(size), diag_list(size)]
      |> Enum.concat

    match_player(Enum.concat(squares), indexes, {:nomatch, nil})
  end

  #________________________
  # match player in squares

  def match_player(_squares, [], {:nomatch, nil}), do: nil

  def match_player(squares, indexes, {:nomatch, nil}) do
    [square_indexes | indexes] = indexes

    player_names = for index <- square_indexes do
      square = Enum.at(squares, index)
      square.marked_by
    end

    [player | player_names] = player_names

    {match, player} = match_player_slice(player, player_names, true)
    match_player(squares, indexes, {match, player})
  end

  def match_player(_squares, _indexes, {:ok, player}), do: player

  #______________________
  # match player in slice

  defp match_player_slice(player, [], _did_find = true), do: {:ok, player}

  defp match_player_slice(player, player_list, _did_find = true) do
    [player2 | player_list] = player_list

    did_find = player && player2 && player.name == player2.name

#    IO.puts "--> did find: #{inspect did_find}"
#    IO.puts "--> player 2: #{inspect player2}"
#    IO.puts "--> player list: #{inspect player_list}"

    match_player_slice(player2, player_list, did_find)
  end


  defp match_player_slice(_player, _player_list, _did_find = false), do: {:nomatch, nil}
  defp match_player_slice(_player, _player_list, _did_find = nil), do: {:nomatch, nil}

  #________________________
  # generate row, col, diag

  def row_list(size) do
    Enum.reduce(0..(size-1), [], fn row, acc ->
      start = size * row
      finish = start + (size-1)
      head = for col <- start..finish do
        col
      end
      [head | acc]
    end)
    |> Enum.sort
  end

  def col_list(size) do
    Enum.reduce(0..(size-1), [], fn row, acc ->
      head = for col <- 0..(size-1) do
        row + (size * col)
      end
      [head | acc]
    end)
    |> Enum.sort
  end

  def diag_list(size) do
    multiplier = [size + 1, size - 1]
    Enum.reduce(0..1, [], fn row, acc ->
      start = row
      finish = start + (size-1)
      head = for col <- start..finish do
        col * Enum.at(multiplier, row)
      end
      [head | acc]
    end)
    |> Enum.sort
  end
end
