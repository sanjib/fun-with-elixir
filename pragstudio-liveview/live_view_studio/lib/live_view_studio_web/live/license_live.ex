defmodule LiveViewStudioWeb.LicenseLive do
  use LiveViewStudioWeb, :live_view

  alias LiveViewStudio.Licenses

  import Number.Currency
  import Inflex

  def mount(_params, _session, socket) do
    expiration_time = Timex.shift(Timex.now(), hours: 1)
    time_remaining = time_remaining(expiration_time)

    if connected?(socket), do: :timer.send_interval(1000, self(), :tick)

    seats = 2
    amount = Licenses.calculate(seats)
    socket = assign(socket,
      seats: seats,
      amount: amount,
      exp_time: expiration_time,
      time_rem: time_remaining,
    )
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1>Team License</h1>
    <div id="license">
      <div class="time-remaining">
        <div class="value"><%= @time_rem %></div>
        <div class="label">Time Remaining</div>
      </div>
      <br>
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

  def handle_info(:tick, socket) do
    time_remaining = socket.assigns.exp_time |> time_remaining
    socket = assign(socket, :time_rem, time_remaining)
    {:noreply, socket}
  end

  def handle_event("update", %{"seats" => seats}, socket) do
    seats = String.to_integer(seats)
    amount = Licenses.calculate(seats)
    socket = assign(socket, seats: seats, amount: amount)
    {:noreply, socket}
  end

  defp time_remaining(expiration_time) do
    Timex.Interval.new(from: Timex.now(), until: expiration_time)
    |> Timex.Interval.duration(:seconds)
    |> Timex.Duration.from_seconds()
    |> Timex.format_duration(:humanized)
  end
end