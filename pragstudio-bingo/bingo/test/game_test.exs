defmodule GameTest do
  use ExUnit.Case

#  alias Bingo.{GameDisplay}
  alias Bingo.{Game, Buzzwords, Player, BingoChecker}

  # Test epiphany:
  # -------------
  # Test not just various cases but also possible failures
  # even though they may look silly. For example see
  # "buzzwords" test below. Simply tests if buzzwords is
  # a list and contains at least an item. In the event of
  # a realistic failure this simple test would be very
  # much practical to detect the event.

  test "buzzwords" do
    buzzwords = Buzzwords.read_buzzwords()

    assert is_list(buzzwords) == true
    assert length(buzzwords) > 1
  end

  test "play game and win" do
    size = 3
    game = Game.new(size)

    sanjib = Player.new("Sanjib", "blue")
    tasnima = Player.new("Tasnima", "green")

    square_list = game.squares |> Enum.concat

    [diag_slice | _] = BingoChecker.diag_list(size)
    [row_slice | _] = BingoChecker.row_list(size)

    diag_squares = diag_slice |> Enum.map(&Enum.at(square_list, &1))
    [_ | row_squares] = row_slice |> Enum.map(&Enum.at(square_list, &1))

    game =
      row_squares
      |> Enum.reduce(game, fn square, game ->
        Game.mark(game, square.phrase, tasnima)
      end)

    game =
      diag_squares
      |> Enum.reduce(game, fn square, game ->
        Game.mark(game, square.phrase, sanjib)
      end)

    # GameDisplay.display(game)
    assert game.winner == sanjib
  end
end