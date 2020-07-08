defmodule LiveViewStudioWeb.SalesDashboardLive do
  use LiveViewStudioWeb, :live_view

  import Number.Currency

  alias LiveViewStudio.Sales

  def mount(_params, _session, socket) do
#    if connected?(socket) do
#      tref = :timer.send_interval(1000, self(), :tick)
#      IO.puts "--> timer ref #{inspect tref}"
#    end

    initial_refresh_interval = 3

    # Don't call LiveViewStudio.Sales initially because mount
    # gets called twice initially, first with the static content
    # then one more time with the join & reply socket calls
    socket = assign(socket,
      new_orders: 0,
      sales_amount: 0,
      satisfaction: 0,
      refresh_interval: initial_refresh_interval
    )

    if connected?(socket) do
      schedule_refresh(socket)
    end

    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1>Sales Dashboard</h1>
    <div id="dashboard">
      <div class="stats">
        <div class="stat">
          <span class="value"><%= @new_orders %></span>
          <span class="name">New Orders</span>
        </div>
        <div class="stat">
          <span class="value"><%= number_to_currency(@sales_amount, precision: 0) %></span>
          <span class="name">Sales Amount</span>
        </div>
        <div class="stat">
          <span class="value"><%= @satisfaction %>%</span>
          <span class="name">Satisfaction</span>
        </div>
      </div>
      <br>

      <form phx-change="update_refresh_interval">
        <select name="refresh_interval">
          <%= options_for_select(refresh_options, @refresh_interval) %>
        </select>
      </form>

      <button phx-click="refresh">Refresh</button>

    </div>

    """
  end

  def handle_event("refresh", _, socket) do
    socket = update_stats(socket)
    {:noreply, socket}
  end

  def handle_event("update_refresh_interval", %{"refresh_interval" => refresh_interval}, socket) do
    refresh_interval = String.to_integer(refresh_interval)
    IO.puts "--> updated refresh interval: #{refresh_interval}"
    socket = assign(socket, :refresh_interval, refresh_interval)
    {:noreply, socket}
  end

  def handle_info(:tick, socket) do
    socket = update_stats(socket)
    {:noreply, socket}
  end

  defp update_stats(socket) do
    schedule_refresh(socket)

    socket
    |> update(:new_orders, &(&1 + Sales.new_orders))
    |> update(:sales_amount, &(&1 + Sales.sales_amount))
    |> assign(:satisfaction, Sales.satisfaction)
  end

  defp refresh_options do
    [{"1s", 1}, {"2s", 2}, {"3s", 3}, {"5s", 5}, {"10s", 10}, {"15s", 15}, {"30s", 30}, {"60s", 60}]
  end

  defp schedule_refresh(socket) do
    refresh_interval = socket.assigns.refresh_interval
    IO.puts "--> refresh interval: #{refresh_interval}"
    Process.send_after(self(), :tick, refresh_interval * 1000)
  end
end