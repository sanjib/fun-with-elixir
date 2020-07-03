defmodule BingoHallWeb.GameController do
  use BingoHallWeb, :controller

  plug :require_player

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"game" => game}) do
    game_name = BingoHall.GameName.get()
    size = String.to_integer(game["size"])

    case Bingo.GameSupervisor.start_game(game_name, size) do
      {:ok, _game_pid} ->
        put_flash conn, :info, "Did to start game!"
        redirect conn, to: Routes.game_path(conn, :show, game_name)

      {:error, _error} ->
        put_flash conn, :error, "Unable to start game!"
        redirect conn, to: Routes.game_path(conn, :new)
    end
  end

  def show(conn, %{"id" => game_name}) do
    case Bingo.GameServer.game_pid(game_name) do
      pid when is_pid(pid) ->
        conn
        |> assign(:game_name, game_name)
        |> assign(:auth_token, generate_auth_token(conn))
        |> render("show.html")
      nil ->
        conn
        |> put_flash(:error, "Game not found!")
        |> redirect(to: Routes.game_path(conn, :new))
    end
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

  defp generate_auth_token(conn) do
    player = get_session(conn, :current_player)
    Phoenix.Token.sign(conn, "player auth", player)
  end

end
