defmodule Calculator.Server do
  use GenServer
  alias Calculator.Core

  def start_link(initial) when is_integer(initial) do
    GenServer.start_link(__MODULE__, initial)
  end

  def init(number) do
    {:ok, number}
  end

  def handle_cast({:add, num}, state) do
    {:noreply, Core.add(state, num)}
  end

  def handle_cast({:subtract, num}, state) do
    {:noreply, Core.subtract(state, num)}
  end

  def handle_cast({:multiply, num}, state) do
    {:noreply, Core.multiply(state, num)}
  end

  def handle_cast({:divide, num}, state) do
    {:noreply, Core.divide(state, num)}
  end

  def handle_cast(:clear, _state) do
    {:noreply, 0}
  end

  def handle_call(:state, _from, state) do
    {:reply, state, state}
  end

  def add(pid, num),      do: GenServer.cast(pid, {:add, num})
  def subtract(pid, num), do: GenServer.cast(pid, {:subtract, num})
  def multiply(pid, num), do: GenServer.cast(pid, {:multiply, num})
  def divide(pid, num),   do: GenServer.cast(pid, {:divide, num})
  def clear(pid, num),    do: GenServer.cast(pid, {:clear, num})

  def state(pid) do
    GenServer.call(pid, :state)
  end
end