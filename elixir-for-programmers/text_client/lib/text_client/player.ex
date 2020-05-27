defmodule TextClient.Player do
  alias TextClient.{Mover, Prompter, State, Summary}

  # won, loss, good_guess, bad_guess, already guessed, initializing

  def play(game = %State{tally: %{game_state: :won}}) do
    Summary.display(game)
    exit_with_msg("YOU WON!")
  end

  def play(game = %State{tally: %{game_state: :lost}}) do
    Summary.display(game)
    exit_with_msg("Sorry, you lost. The word was: #{Enum.join(game.game_service.letters)}.")
  end

  def play(game = %State{tally: %{game_state: :good_guess}}), do: continue(game, "Good guess!")

  def play(game = %State{tally: %{game_state: :bad_guess}}),
    do: continue(game, "Sorry, no match.")

  def play(game = %State{tally: %{game_state: :already_used}}),
    do: continue(game, "Already guessed.")

  def play(game), do: continue(game)

  ###################### ↓↓↓ PRIVATE ↓↓↓ ######################

  defp continue(game, msg) do
    IO.puts(msg)
    continue(game)
  end

  defp continue(game) do
    game
    |> Summary.display()
    |> Prompter.accept_move()
    |> Mover.make_move()
    |> play()
  end

  defp exit_with_msg(msg) do
    IO.puts(msg)
    exit(:normal)
  end
end
