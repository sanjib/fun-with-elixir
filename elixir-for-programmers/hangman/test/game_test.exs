defmodule GameTest do
  use ExUnit.Case

  alias Hangman.Game

  test "new_game returns struct" do
    game = Game.new_game()

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert length(game.letters) > 0
    assert game.letters |> List.to_string() =~ ~r/[a-z]/
  end

  test "state isn't changed for :won or :lost game" do
    for state <- [:won, :lost] do
      game = Game.new_game() |> Map.put(:game_state, state)
      # IO.inspect(game)
      assert {^game, _tally} = Game.make_move(game, "x")
    end
  end

  test "first occurrence of letter is not already used" do
    game = Game.new_game()
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state != :already_used
  end

  test "second occurrence of letter is already used" do
    game = Game.new_game()
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state != :already_used
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state == :already_used
  end

  test "a good guess is recognized" do
    game = Game.new_game("wibble")
    {game, _tally} = Game.make_move(game, "w")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
  end

  test "guess the whole word" do
    game = Game.new_game("wibble")
    {game, _tally} = Game.make_move(game, "w")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
    {game, _tally} = Game.make_move(game, "i")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
    {game, _tally} = Game.make_move(game, "b")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
    {game, _tally} = Game.make_move(game, "l")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
    {game, _tally} = Game.make_move(game, "e")
    assert game.game_state == :won
    assert game.turns_left == 7
    # IO.inspect(game)
  end

  test "bad guess is recognized" do
    game = Game.new_game("wibble")
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state == :bad_guess
    assert game.turns_left == 6
  end

  test "lost game is recognized" do
    game = Game.new_game("w")
    {game, _tally} = Game.make_move(game, "a")
    assert game.game_state == :bad_guess
    assert game.turns_left == 6
    {game, _tally} = Game.make_move(game, "b")
    assert game.game_state == :bad_guess
    assert game.turns_left == 5
    {game, _tally} = Game.make_move(game, "c")
    assert game.game_state == :bad_guess
    assert game.turns_left == 4
    {game, _tally} = Game.make_move(game, "d")
    assert game.game_state == :bad_guess
    assert game.turns_left == 3
    {game, _tally} = Game.make_move(game, "e")
    assert game.game_state == :bad_guess
    assert game.turns_left == 2
    {game, _tally} = Game.make_move(game, "f")
    assert game.game_state == :bad_guess
    assert game.turns_left == 1
    {game, _tally} = Game.make_move(game, "g")
    assert game.game_state == :lost
    assert game.turns_left == 0
    # IO.inspect(game)
  end

  test "win game with list & custom def" do
    moves = [
      {"w", :good_guess},
      {"i", :good_guess},
      {"b", :good_guess},
      {"l", :good_guess},
      {"e", :won}
    ]

    game = Game.new_game("wibble")
    check_moves(moves, game)
  end

  def check_moves([], game), do: game

  def check_moves([{guess, state} | tail_moves], game) do
    {game, _tally} = Game.make_move(game, guess)
    assert game.game_state == state
    assert game.turns_left == 7
    check_moves(tail_moves, game)
  end

  test "win game with list & Enum.reduce" do
    moves = [
      {"w", :good_guess},
      {"i", :good_guess},
      {"b", :good_guess},
      {"l", :good_guess},
      {"e", :won}
    ]

    game = Game.new_game("wibble")

    Enum.reduce(moves, game, fn {guess, state}, game ->
      {game, _tally} = Game.make_move(game, guess)
      assert game.game_state == state
      assert game.turns_left == 7
      game
    end)
  end

  def foo, do: :bar
end
