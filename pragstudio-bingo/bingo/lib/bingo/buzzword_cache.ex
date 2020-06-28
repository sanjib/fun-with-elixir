defmodule Bingo.BuzzwordCache do
  @moduledoc false

  use GenServer

  @name __MODULE__

  #____________________
  # Client interface

  def start_link([filename, refresh_interval]) do
    IO.puts "Starting Buzzword Cache server..."
    GenServer.start_link(__MODULE__, {filename, refresh_interval}, name: @name)
  end

  def get_buzzwords() do
    GenServer.call @name, :get_buzzwords
  end

  def set_refresh_interval(interval) do
    GenServer.cast @name, {:set_refresh_interval, interval}
  end

  #____________________
  # Server callbacks

  def init({filename, refresh_interval}) do
    buzzwords = Bingo.Buzzwords.read_buzzwords(filename)
    timer_ref = schedule_refresh(refresh_interval, nil)
    {:ok,
      %{buzzwords: buzzwords,
        filename: filename,
        refresh_interval: refresh_interval,
        timer_ref: timer_ref,
      }
    }
  end

  def handle_call(:get_buzzwords, _from, state) do
    {:reply, state.buzzwords, state}
  end

  def handle_cast({:set_refresh_interval, interval}, state) do
    new_timer_ref = schedule_refresh(interval, state.timer_ref)
    {:noreply, %{state | refresh_interval: interval, timer_ref: new_timer_ref}}
  end

  def handle_info(:refresh, state) do
    buzzwords = Bingo.Buzzwords.read_buzzwords(state.filename)
    IO.puts "--> refreshed! buzzwords: #{inspect buzzwords}"

    new_timer_ref = schedule_refresh(state.refresh_interval, state.timer_ref)
    {:noreply, %{state | buzzwords: buzzwords, timer_ref: new_timer_ref}}
  end

  #_____________________
  # Helpers

  defp schedule_refresh(refresh_after, timer_ref) do
    if timer_ref != nil, do: Process.cancel_timer(timer_ref)
    Process.send_after(@name, :refresh, refresh_after)
  end

end
