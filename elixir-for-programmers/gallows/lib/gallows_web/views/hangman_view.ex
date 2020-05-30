defmodule GallowsWeb.HangmanView do
  use GallowsWeb, :view

  import GallowsWeb.HangmanView.Helpers.GameStateHelper

  def turn(left, target) when target >= left do
    "opacity: 1"
  end

  def turn(left, target) do
    "opacity: 0.1"
  end

  def game_over?(%{game_state: game_state}) do
    game_state in [:won, :lost]
  end

  def game_lost?(%{game_state: game_state}) do
    game_state in [:lost]
  end

  def new_game_button(conn) do
    button("New Game", to: Routes.hangman_path(conn, :create_game))
  end
end
