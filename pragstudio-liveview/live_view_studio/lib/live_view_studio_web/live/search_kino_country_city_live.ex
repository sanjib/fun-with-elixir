defmodule LiveViewStudioWeb.SearchKinoCountryCityLive do
  use LiveViewStudioWeb, :live_view

  alias LiveViewStudio.KinokuniyaStores

  def mount(_params, _session, socket) do
    socket = assign(socket,
      city: "",
      country: "",
      stores: []
    )

    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1>Kinokuniya Stores</h1>
    <div id="search">
      <form phx-change="search">
        <input type="text" name="search" placeholder="Type a city or country" autofocus autocomplete="off" />
      </form>

      <div class="stores">
        <ul>
          <%= for store <- @stores do %>
            <li>
              <div class="address"><%= store.address1 %><br><%= store.address2 %></div>
              <div class="city_state_zip"><%= store.city %>, <%= store.state %> <%= store.zip %></div>
              <div class="country"><%= store.country %></div>
              <div class="phone">Phone: <%= store.phone %></div>
              <div class="opening_hours">Opening Hours: <%= store.opening_hours %></div>
            </li>
          <% end %>
        </ul>
      </div>
    </div>

    """
  end

  def handle_event("search", %{"search" => search}, socket) do
    IO.puts "--> search: #{search}"
    stores =
      if String.length(search) > 2 do
        KinokuniyaStores.list_by_city_fuzzy(search)
        |> Enum.concat(KinokuniyaStores.list_by_country_fuzzy(search))
        |> Enum.uniq
      else
        []
      end

    IO.puts "--> stores: #{inspect stores}"
    socket = assign(socket, stores: stores)
    {:noreply, socket}
  end
end