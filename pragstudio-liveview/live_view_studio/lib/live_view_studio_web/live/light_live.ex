defmodule LiveViewStudioWeb.LightLive do
  use LiveViewStudioWeb, :live_view

  def mount(_params, _session, socket) do
    # IO.puts "--> MOUNT #{inspect self()}"
    socket = assign(socket,
      brightness: 10,
      temp: 3000
    )
    {:ok, socket}
  end

  def render(assigns) do
    # IO.puts "--> RENDER #{inspect self()}"
    ~L"""
    <h1>Front Porch Light</h1>
    <div class="light">
      <div class="meter">
        <span style="width: <%= @brightness %>%; background-color: <%= temp_color(@temp) %>;">
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
    <form phx-change="update">
      <input type="range" name="brightness" value="<%= @brightness %>" min="0" max="100" step="10" />

      <%= @temp %>
      
      <label><%= radio_button(:temp, :temp, "3000", checked: (if @temp == 3000, do: true)) %> 3000</label>
      <label><%= radio_button(:temp, :temp, "4000", checked: (if @temp == 4000, do: true)) %> 4000</label>
      <label><%= radio_button(:temp, :temp, "5000", checked: (if @temp == 5000, do: true)) %> 5000</label>
    </form>

    """
  end

  def handle_event("update", %{"brightness" => brightness, "temp" => temp}, socket) do
    brightness = String.to_integer(brightness)
    temp = String.to_integer(temp["temp"])
    socket = assign(socket, brightness: brightness, temp: temp)
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
    # IO.puts "--> ON #{inspect self()}"
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

  #________________
  
  defp temp_color(3000), do: "#F1C40D"
  defp temp_color(4000), do: "#FEFF66"
  defp temp_color(5000), do: "#99CCFF"

end
