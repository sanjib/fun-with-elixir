defmodule LiveViewStudioWeb.LicenseLive do
  use LiveViewStudioWeb, :live_view

  alias LiveViewStudio.Licenses

  import Number.Currency
  import Inflex

  def mount(_params, _session, socket) do
    seats = 2
    amount = Licenses.calculate(seats)
    socket = assign(socket, seats: seats, amount: amount)
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1>Team License</h1>
    <div id="license">
      <div class="card">
        <div class="content">
          <div class="seats">
            <span>
              Your license is currently for
              <strong><%= @seats %></strong>
              <%= Inflex.inflect("seats", @seats) %>.
            </span>
          </div>
          <form phx-change="update">
            <input type="range" min="1" max="10" name="seats" value="<%= @seats %>" />
          </form>
          <div class="amount">
            <%= number_to_currency(@amount, unit: "€", precision: 2, delimiter: ".", separator: ",") %>
          </div>
        </div>
      </div>
    </div>

    """
  end

  def handle_event("update", %{"seats" => seats}, socket) do
    seats = String.to_integer(seats)
    amount = Licenses.calculate(seats)
    socket = assign(socket, seats: seats, amount: amount)
    {:noreply, socket}
  end
end