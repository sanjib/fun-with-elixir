defmodule GameServerTest do
  use ExUnit.Case

  test "game server squares length" do
    Bingo.GameServer.start_link("inky-night", 3)
    Bingo.GameServer.start_link("icy-sun", 4)

    game_inky_night = Bingo.GameServer.summary("inky-night")
    game_icy_sun = Bingo.GameServer.summary("icy-sun")

    assert length(game_inky_night.squares) == 3
    assert length(game_icy_sun.squares) == 4
  end

  test "game server winner" do
    Bingo.GameServer.start_link("inky-night", 3)
    nicole = Bingo.Player.new("Nicole", "yellow")
    game = Bingo.GameServer.summary("inky-night")

    answer_phrases =
      game.squares
      |> Enum.concat
      |> Enum.take(3)
      |> Enum.map(fn square -> square.phrase end)

    game =
      answer_phrases
      |> Enum.reduce(game, fn phrase, _game ->
        Bingo.GameServer.mark("inky-night", phrase, nicole)
      end)

    assert game.winner == nicole
  end

end