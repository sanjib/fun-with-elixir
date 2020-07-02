defmodule BingoHallWeb.GameController do
  use BingoHallWeb, :controller

  plug :require_player

  def new(conn, _params) do
    IO.inspect get_session(conn, :current_player)
    render(conn, "new.html")
  end

  def create(_conn, _params) do

  end

  def show(_conn, _params) do
    
  end

  defp require_player(conn, _opts) do
    if get_session(conn, :current_player) do
      conn
    else
      conn
      |> put_session(:return_to, conn.request_path)
      |> redirect(to: Routes.session_path(conn, :new))
      |> halt
    end
  end

end
