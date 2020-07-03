defmodule BingoHallWeb.GameChannel do
  use BingoHallWeb, :channel

  def join("games:" <> game_name, _params, socket) do
    case Bingo.GameServer.game_pid(game_name) do
      pid when is_pid(pid) ->
        send self(), {:after_join, game_name}
        {:ok, socket}
      nil ->
        {:error, %{reason: "Game does not exist!"}}
    end
  end

  def handle_info({:after_join, game_name}, socket) do
    summary = Bingo.GameServer.summary(game_name)
    #IO.inspect summary

    push(socket, "game_summary", summary)

    push(socket, "presence_state", Presence.list(socket))

    {:ok, _} =
      Presence.track(socket, current_player(socket).name, %{
        online_at: inspect(System.system_time(:seconds)),
        color: current_player(socket).color
      })

    {:noreply, socket}
  end

  def handle_in("mark_square", %{"phrase" => phrase}, socket) do
    "games:" <> game_name = socket.topic

    case Bingo.GameServer.game_pid(game_name) do
      pid when is_pid(pid) ->
        summary = Bingo.GameServer.mark(game_name, phrase, current_player(socket))
        broadcast!(socket, "game_summary", summary)
        {:noreply, socket}
      nil ->
        {:reply, {:error, %{reason: "Game does not exist"}}, socket}
    end
  end

  def handle_in("new_chat_message", %{"body" => body}, socket) do
    broadcast!(socket, "new_chat_message", %{
      name: current_player(socket).name,
      body: body
    })
    {:noreply, socket}
  end

  defp current_player(socket) do
    socket.assigns.current_player
  end
end