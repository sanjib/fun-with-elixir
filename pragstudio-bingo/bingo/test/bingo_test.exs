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

  test "test marked by" do

  end

end
