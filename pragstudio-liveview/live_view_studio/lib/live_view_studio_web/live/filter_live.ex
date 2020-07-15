defmodule LiveViewStudioWeb.FilterLive do
  use LiveViewStudioWeb, :live_view

  alias LiveViewStudio.Boats

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(
           boats: Boats.list_boats(),
           type: "",
           prices: %{}
         )
    {:ok, socket, temporary_assigns: [boats: []]}
  end

  def handle_event("filter", %{"type" => type, "prices" => prices}, socket) do
    prices_query =
      prices
      |> Enum.reduce([], fn {key, value}, prices ->
        if value == "true", do: [key | prices], else: prices
      end)

#    IO.puts "--> prices #{inspect prices}"
#    IO.puts "--> prices #{inspect prices_query}"

    boats = list_boats_from_query(type, prices_query)
    socket =
      socket
      |> assign(
           boats: boats,
           type: type,
           prices: prices
         )

    {:noreply, socket}
  end

  defp list_boats_from_query(type, []), do: Boats.list_boats(type: type)
  defp list_boats_from_query(type, prices), do: Boats.list_boats(type: type, prices: prices)

  defp boat_types() do
    [
      "All Types": "",
      Fishing: "fishing",
      Sailing: "sailing",
      Sporting: "sporting",
    ]
  end

  def render(assigns) do
    ~L"""
    <h1>Daily Boat Rentals</h1>
    <div id="filter">
      <form phx-change="filter">
        <div class="filters">
          <select name="type">
            <%= options_for_select(boat_types(), @type) %>
          </select>
          <div class="prices">
            <label><%= checkbox(:prices, "$", value: @prices["$"]) %> $</label>
            <label><%= checkbox(:prices, "$$", value: @prices["$$"]) %> $$</label>
            <label><%= checkbox(:prices, "$$$", value: @prices["$$$"]) %> $$$</label>
          </div>
        </div>
      </form>

      <div class="boats">
        <%= for boat <- @boats do %>
          <div class="card">
            <img src="<%= boat.image %>">
            <div class="content">
              <div class="model">
                <%= boat.model %>
              </div>
              <div class="details">
                <span class="price">
                  <%= boat.price %>
                </span>
                <span class="type">
                  <%= boat.type %>
                </span>
              </div>
            </div>
          </div>
        <% end %>
      </div>
    </div>

    """
  end
end