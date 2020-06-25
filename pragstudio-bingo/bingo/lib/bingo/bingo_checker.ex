defmodule Bingo.BingoChecker do
  @moduledoc "Determines if a bingo has been achieved by examining squares"

  def bingo?(_squares) do

  end

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
