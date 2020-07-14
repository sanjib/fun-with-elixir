defmodule LiveViewStudioWeb.FlightsLive do
  use LiveViewStudioWeb, :live_view

  alias LiveViewStudio.Flights

  def mount(_params, _session, socket) do
    socket = assign(socket,
      loading: false,
      flight_number: "",
      flights: []
    )
    {:ok, socket}
  end

  def handle_info({:search_flights, flight_number}, socket) do
    case Flights.search_by_number(flight_number) do
      [] ->
        socket =
          socket
          |> put_flash(:info, "The flight \"#{flight_number}\" could not be found!")
          |> assign(loading: false, flights: [])
        {:noreply, socket}
      flights ->
        socket = assign(socket,
          loading: false,
          flights: flights
        )
        {:noreply, socket}
    end
  end

  def handle_event("search_flights", %{"flight_number" => flight_number}, socket) do
    send self(), {:search_flights, flight_number}

    socket =
      socket
      |> clear_flash
      |> assign(loading: true, flight_number: flight_number, flights: [])
    {:noreply, socket}
  end

  def render(assigns) do
    ~L"""
    <h1>Find a Flight</h1>
    <div id="search">

    <form phx-submit="search_flights">
      <input type="text" name="flight_number"
        value="<%= @flight_number %>"
        placeholder="Flight Number"
        <%= if @loading, do: "readonly" %>
        autofocus autocomplete="off" />
      <button type="submit">Search</button>
    </form>

      <%= if @loading do %>
        <div class="loader">
          <div class="bounce1"></div>
          <div class="bounce2"></div>
          <div class="bounce3"></div>
        </div>
      <% end %>

      <div class="flights">
        <ul>
          <%= for flight <- @flights do %>
            <li>
              <div class="first-line">
                <div class="number">
                  Flight #<%= flight.number %>
                </div>
                <div class="origin-destination">
                  <img src="images/location.svg">
                  <%= flight.origin %> to
                  <%= flight.destination %>
                </div>
              </div>
              <div class="second-line">
                <div class="departs">
                  Departs: <%= Timex.format!(flight.departure_time, "%b %d at %H:%M", :strftime) %>
                </div>
                <div class="arrives">
                  Arrives: <%= Timex.format!(flight.arrival_time, "%b %d at %H:%M", :strftime) %>
                </div>
              </div>
            </li>
          <% end %>
        </ul>
      </div>
    </div>
    """
  end

end