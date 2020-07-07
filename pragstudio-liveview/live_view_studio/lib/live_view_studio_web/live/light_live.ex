defmodule LiveViewStudioWeb.LightLive do
  use LiveViewStudioWeb, :live_view

  def mount(_params, _session, socket) do
    IO.puts "--> MOUNT #{inspect self()}"
    socket = assign(socket, :brightness, 10)
    {:ok, socket}
  end

  def render(assigns) do
    IO.puts "--> RENDER #{inspect self()}"
    ~L"""
    <h1>Front Porch Light</h1>
    <div id="light">
      <div class="meter">
        <span style="width: <%= @brightness %>%">
          <%= @brightness %>%
        </span>
      </div>
    </div>
    <br>
    <button phx-click="off">Off</button>
    <button phx-click="down">⯆</button>
    <button phx-click="up">⯅</button>
    <button phx-click="on">On</button>
    <br>
    <button phx-click="random">Random</button>
    <form phx-change="range_update_brightness">
      <input type="range" name="brightness" value="<%= @brightness %>" min="0" max="100" step="10" />
    </form>

    """
  end

  def handle_event("range_update_brightness", %{"brightness" => brightness}, socket) do
    brightness = String.to_integer(brightness)
    socket = assign(socket, brightness: brightness)
    {:noreply, socket}
  end

  def handle_event("random", _, socket) do
    socket = assign(socket, :brightness, Enum.random(0..10) * 10)
    #socket = assign(socket, :brightness, :rand.uniform(100))
    {:noreply, socket}
  end

  def handle_event("off", _, socket) do
    socket = assign(socket, :brightness, 0)
    {:noreply, socket}
  end

  def handle_event("on", _, socket) do
    IO.puts "--> ON #{inspect self()}"
    socket = assign(socket, :brightness, 100)
    {:noreply, socket}
  end

  def handle_event("down", _, socket) do
    socket = update(socket, :brightness, &max(0, &1 - 10))
    {:noreply, socket}
  end

  def handle_event("up", _, socket) do
    socket = update(socket, :brightness, &min(100, &1 + 10))
    {:noreply, socket}
  end

end
