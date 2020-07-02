defmodule BingoHallWeb.SessionController do
  use BingoHallWeb, :controller

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"player" => player}) do
    player = Bingo.Player.new(player["name"], player["color"])

    conn
    |> put_session(:current_player, player)
    |> redirect_back_or_to_new_game
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:current_player)
    |> redirect(to: "/")
  end

  defp redirect_back_or_to_new_game(conn) do
    path = get_session(conn, :return_to) || Routes.game_path(conn, :new)

    conn
    |> put_session(:return_to, nil)
    |> redirect(to: path)
  end

end