defmodule LiveViewStudioWeb.SalesDashboardLive do
  use LiveViewStudioWeb, :live_view

  import Number.Currency

  alias LiveViewStudio.Sales

  def mount(_params, _session, socket) do
    if connected?(socket), do: :timer.send_interval(1000, self(), :tick)

    socket = assign(socket,
      new_orders: Sales.new_orders(),
      sales_amount: Sales.sales_amount(),
      satisfaction: Sales.satisfaction(),
    )
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
          <span class="value"><%= number_to_currency(@sales_amount, precision: 0,) %></span>
          <span class="name">Sales Amount</span>
        </div>
        <div class="stat">
          <span class="value"><%= @satisfaction %>%</span>
          <span class="name">Satisfaction</span>
        </div>
      </div>
      <br>
      <button phx-click="refresh">Refresh</button>
    </div>

    """
  end

  def handle_event("refresh", _, socket) do
    {:noreply, update_stats(socket)}
  end

  def handle_info(:tick, socket) do
    {:noreply, update_stats(socket)}
  end

  defp update_stats(socket) do
    socket
    |> update(:new_orders, &(&1 + Sales.new_orders))
    |> update(:sales_amount, &(&1 + Sales.sales_amount))
    |> assign(:satisfaction, Sales.satisfaction)
  end
end