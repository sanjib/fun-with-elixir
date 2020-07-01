defmodule GameSupervisorTest do
  use ExUnit.Case

  test "create" do
    game_name = "inky-night"
    game_size = 3
    Bingo.GameSupervisor.start_game(game_name, game_size)
    game = Bingo.GameServer.summary(game_name)

    # ASSERT GAME SIZE
    assert length(game.squares) == game_size

    # STOP GAME - so it doesn't interfere with other tests
    Bingo.GameSupervisor.stop_game(game_name)
  end

  test "mark and winner" do
    game_name = "icy-sun"
    game_size = 4
    player = Bingo.Player.new("Player 1", "yellow")
    Bingo.GameSupervisor.start_game(game_name, game_size)
    game = Bingo.GameServer.summary(game_name)

    # ASSERT WINNER
    [squares | _] = game.squares
    game =
      squares
      |> Enum.reduce(game, fn square, _game ->
        Bingo.GameServer.mark(game_name, square.phrase, player)
      end)
    assert game.winner == player

    # STOP GAME - so it doesn't interfere with other tests
    Bingo.GameSupervisor.stop_game(game_name)
  end

  test "alive?" do
    game_name = "halo-rising"
    game_size = 3
    Bingo.GameSupervisor.start_game(game_name, game_size)

    # ASSERT GAME IS ALIVE
    pid = Bingo.GameServer.game_pid(game_name)
    assert Process.alive?(pid) == true
    Bingo.GameSupervisor.stop_game(game_name)
    assert Process.alive?(pid) == false
  end

  test "game names" do
    game1_name = "tin-bar"
    game1_size = 2
    game2_name = "mat-kin"
    game2_size = 3
    game3_name = "sun-fur"
    game3_size = 4
    Bingo.GameSupervisor.start_game(game1_name, game1_size)
    Bingo.GameSupervisor.start_game(game2_name, game2_size)
    Bingo.GameSupervisor.start_game(game3_name, game3_size)

    # ASSERT GAME NAMES
    game_names = [game1_name, game2_name, game3_name] |> Enum.sort
    assert Bingo.GameSupervisor.game_names() == game_names

    # STOP GAME - so it doesn't interfere with other tests
    Bingo.GameSupervisor.stop_game(game1_name)
    Bingo.GameSupervisor.stop_game(game2_name)
    Bingo.GameSupervisor.stop_game(game3_name)
  end

  test "game state after exit" do
    game_name = "twice-reborn"
    game_size = 3
    {:ok, game_pid} = Bingo.GameSupervisor.start_game(game_name, game_size)
    game = Bingo.GameServer.summary(game_name)
    phrases_row1 = game.squares |> List.first |> Enum.map(fn square -> square.phrase end)

    # ASSERT FIRST ROW OF PHRASES AFTER EXIT
    # AKA SAME GAME STATE
    Process.exit(game_pid, :terminate)
    # sleep a little for process to start!
    # a better option might be to receive a message
    # or maybe monitor the process
    :timer.sleep(100)

    game_reborn = Bingo.GameServer.summary(game_name)
    phrases_row1_game_reborn = game_reborn.squares |> List.first |> Enum.map(fn square -> square.phrase end)

    assert phrases_row1 == phrases_row1_game_reborn
  end

end