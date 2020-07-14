defmodule LiveViewStudioWeb.SearchLive do
  use LiveViewStudioWeb, :live_view

  alias LiveViewStudio.KinokuniyaStores

  def mount(_params, _session, socket) do
    socket = assign(socket,
      zip: "",
      stores: [],
      loading: false
    )
    {:ok, socket}
  end

  def handle_info({:run_zip_search, zip}, socket) do
    case KinokuniyaStores.list_by_zip(zip) do
      [] ->
        socket =
          socket
          |> put_flash(:info, "No stores matching \"#{zip}\"")
          |> assign(stores: [], loading: false)
        {:noreply, socket}

      stores ->
        socket = assign(socket, stores: stores, loading: false)
        {:noreply, socket}
    end
  end

  def handle_event("zip-search", %{"zip" => zip}, socket) do
    send self(), {:run_zip_search, zip}

    socket =
      socket
      |> clear_flash
      |> assign(zip: zip, stores: [], loading: true)

    {:noreply, socket}
  end

  defp readonly(true), do: "readonly"
  defp readonly(false), do: ""

  defp loading_anim(true) do
    """
    <div class="loader">
      <div class="bounce1"></div>
      <div class="bounce2"></div>
      <div class="bounce3"></div>
    </div>
    """
  end

  defp loading_anim(false), do: ""

  def render(assigns) do
    ~L"""
    <h1>Kinokuniya Stores</h1>
    <div id="search">
      <form phx-submit="zip-search">
        <input type="text" name="zip" value="<%= @zip %>" 
          placeholder="Zip Code" 
          <%= raw readonly(@loading) %>
          autofocus autocomplete="off" />
        <button type="submit">Search</button>
      </form>

      <%= raw loading_anim(@loading) %>

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
end