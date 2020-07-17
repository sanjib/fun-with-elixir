defmodule LiveViewStudioWeb.LightLive do
  use LiveViewStudioWeb, :live_view

  def mount(_params, _session, socket) do
    # IO.puts "--> MOUNT #{inspect self()}"
    socket = assign(socket,
      brightness: 10,
      selected_temp: 3000
    )
    {:ok, socket}
  end

  def render(assigns) do
    # IO.puts "--> RENDER #{inspect self()}"
    ~L"""
    <h1>Front Porch Light</h1>
    <div class="light">
      <div class="meter">
        <span style="width: <%= @brightness %>%; background-color: <%= temp_color(@selected_temp) %>;">
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

      <%= for temp <- [3000, 4000, 5000] do %>
        <%= radio_button_temp(%{
            temp: temp,
            selected_temp: @selected_temp
          }) %>
      <% end %>

    </form>

    """
  end

  def handle_event("update", %{"brightness" => brightness, "temp" => temp}, socket) do
    brightness = String.to_integer(brightness)
    temp = String.to_integer(temp["temp"])
    socket = assign(socket, brightness: brightness, selected_temp: temp)
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

  defp radio_button_temp(assigns) do
    ~L"""
    <label>
      <%= radio_button(:temp, :temp, "#{@temp}", checked: (if @selected_temp == @temp, do: true)) %>
      <%= @temp %>
    </label>
    """
  end

  defp temp_color(3000), do: "#F1C40D"
  defp temp_color(4000), do: "#FEFF66"
  defp temp_color(5000), do: "#99CCFF"

end
