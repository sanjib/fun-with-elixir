defmodule BingoTest do
  use ExUnit.Case
  doctest Bingo

  test "square size" do
    size = 4
    game = Bingo.Game.new(size)

    row_size = length(game.squares)
    total_size = length(Enum.concat(game.squares))

    assert row_size == size
    assert total_size == size * size
  end

  test "bing checker row list" do
    size = 5
    expected = [
      [ 0,  1,  2,  3,  4],
      [ 5,  6,  7,  8,  9],
      [10, 11, 12, 13, 14],
      [15, 16, 17, 18, 19],
      [20, 21, 22, 23, 24],
    ]
    assert expected == Bingo.BingoChecker.row_list(size)
  end

  test "bing checker col list" do
    size = 5
    expected = [
      [ 0,  5, 10, 15, 20],
      [ 1,  6, 11, 16, 21],
      [ 2,  7, 12, 17, 22],
      [ 3,  8, 13, 18, 23],
      [ 4,  9, 14, 19, 24],
    ]
    assert expected == Bingo.BingoChecker.col_list(size)
  end

  test "bing checker diag list" do
    size = 5
    expected = [
      [ 0,  6, 12, 18, 24],
      [ 4,  8, 12, 16, 20],
    ]
    assert expected == Bingo.BingoChecker.diag_list(size)
  end
end
