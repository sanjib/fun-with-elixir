defmodule Servy.SensorServer do
  use GenServer

  @name __MODULE__
  #@refresh_interval :timer.seconds(5) # in production, use :timer.minutes(60)

  defmodule State do
    defstruct sensor_data: %{},
              timer_ref: nil,
              refresh_interval: :timer.minutes(60)
  end

  # Client interface

  def start_link(interval) do
    IO.puts "Starting the Sensor Server with #{interval} min refresh..."
    #state = %State{}
    #state = %{state | refresh_interval: :timer.minutes(interval)}
    state = %State{refresh_interval: :timer.minutes(interval)}
    GenServer.start_link(__MODULE__, state, name: @name)
  end

  def get_sensor_data() do
    GenServer.call @name, :get_sensor_data
  end

  def set_refresh_interval(time) do
    GenServer.cast @name, {:set_refresh_interval, time}
  end

  # Server callbacks

  def init(state) do
    sensor_data = run_tasks_to_get_sensor_data()
    timer_ref = schedule_refresh(state.refresh_interval)
    {:ok, %{state | sensor_data: sensor_data, timer_ref: timer_ref}}
  end

  def handle_call(:get_sensor_data, _from, state) do
    {:reply, state.sensor_data, state}
  end

  def handle_cast({:set_refresh_interval, time}, state) do
    Process.cancel_timer(state.timer_ref)
    timer_ref = schedule_refresh(time)
    {:noreply, %{state | refresh_interval: time, timer_ref: timer_ref}}
  end

  def handle_info(:refresh, state) do
    IO.puts "Refreshing the cache..."
    sensor_data = run_tasks_to_get_sensor_data()
    timer_ref = schedule_refresh(state.refresh_interval)
    {:noreply, %{state | sensor_data: sensor_data, timer_ref: timer_ref}}
  end

  #________________________________________________________
  # Helper functions

  defp schedule_refresh(refresh_interval) do
    Process.send_after(self(), :refresh, refresh_interval)
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
