defmodule Servy.SensorServer do
  use GenServer

  @name __MODULE__
  @refresh_interval :timer.seconds(5) # in production, use :timer.minutes(60)

  # Client interface

  def start() do
    GenServer.start(__MODULE__, %{}, name: @name)
  end

  def get_sensor_data() do
    GenServer.call(@name, :get_sensor_data)
  end

  # Server callbacks

  def init(_state) do
    initial_state = run_tasks_to_get_sensor_data()
    schedule_refresh()
    {:ok, initial_state}
  end

  def handle_call(:get_sensor_data, _from, state) do
    {:reply, state, state}
  end

  def handle_info(:refresh, _state) do
    IO.puts "Refreshing the cache..."
    new_state = sensor_data = run_tasks_to_get_sensor_data()
    schedule_refresh()
    {:noreply, new_state}
  end

  defp schedule_refresh() do
    Process.send_after(self(), :refresh, @refresh_interval)
  end

  defp run_tasks_to_get_sensor_data() do
    IO.puts "Running tasks to get sensor data..."

    task = Task.async(fn -> Servy.TrackerPristine.get_location("bigfoot") end)

    snapshots =
      ["cam-1", "cam-2", "cam-3"]
      |> Enum.map(&Task.async(fn -> Servy.VideoCam.get_snapshot(&1) end))
      |> Enum.map(&Task.await/1)

    where_is_bigfoot = Task.await(task)

    %{snapshots: snapshots, location: where_is_bigfoot}
  end

end
