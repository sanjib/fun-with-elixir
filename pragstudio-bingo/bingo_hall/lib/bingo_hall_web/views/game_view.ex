defmodule BingoHallWeb.GameView do
  use BingoHallWeb, :view

  def game_url(conn) do
    Routes.url(conn) <> conn.request_path
  end

  def ws_url() do
    System.get_env("WS_URL") || BingoHallWeb.Endpoint.config(:ws_url)
  end
end