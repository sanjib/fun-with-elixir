defmodule Servy.PledgeServer do

#  @name :pledge_server
  @name __MODULE__

  use GenServer

  defmodule State do
    defstruct cache_size: 3, pledges: []
  end

  #________________________________________________
  # Client interface

  def start() do
    IO.puts "Starting the pledge server..."
    GenServer.start(__MODULE__, %State{}, name: @name)
  end

  def create_pledge(name, amount) do
    GenServer.call @name, {:create_pledge, name, amount}
    # send @name, {self(), :create_pledge, name, amount}
    # receive do {:response, status} -> status end
  end

  def recent_pledges() do
    GenServer.call @name, :recent_pledges
    # send @name, {self(), :recent_pledges}

    # receive is a blocking call
    # so the function recent_pledges as a whole
    # is synchronous
    # receive do {:response, pledges} -> pledges end
  end

  def total_pledged() do
    GenServer.call @name, :total_pledged
    # send @name, {self(), :total_pledged}
    # receive do {:response, total} -> total end
  end

  def clear() do
    GenServer.cast @name, :clear
  end

  def set_cache_size(size) do
    GenServer.cast @name, {:set_cache_size, size}
  end

  #________________________________________________
  # Server Callbacks

  def init(state) do
    pledges = fetch_recent_pledges_from_service()
    new_state = %{state | pledges: pledges}
    {:ok, new_state}
  end

  def handle_cast(:clear, state), do: {:noreply, %{state | pledges: []}}

  def handle_cast({:set_cache_size, size}, state) do
    most_recent_pledges = Enum.take(state.pledges, size)
    new_state = %{state | cache_size: size, pledges: most_recent_pledges}
    {:noreply, new_state}
  end

  def handle_call({:create_pledge, name, amount}, _from, state) do
    {:ok, id} = send_pledge_to_service(name, amount)
    most_recent_pledges = Enum.take(state.pledges, state.cache_size - 1)
    cached_pledges = [{name, amount} | most_recent_pledges]
    new_state = %{state | pledges: cached_pledges}
    {:reply, id, new_state}
  end

  def handle_call(:recent_pledges, _from, state), do: {:reply, state.pledges, state}

  def handle_call(:total_pledged, _from, state) do
    # total = Enum.reduce(state.pledges, 0, fn {_name, amount}, acc -> amount + acc  end)
    total = Enum.map(state.pledges, &elem(&1, 1)) |> Enum.sum
    {:reply, total, state}
  end

  def handle_info(message, state) do
    IO.puts "Can't touch this! #{inspect message}"
    {:noreply, state}
  end

  #_____________________________________________

  defp send_pledge_to_service(_name, _amount) do
    # code to send pledges to external service

    {:ok, "pledge-#{:rand.uniform(1000)}"}
  end

  defp fetch_recent_pledges_from_service do
    # code to fetch pledges from external service

    [{"wilma", 15}, {"fred", 25}]
  end
end

alias Servy.PledgeServer
{:ok, pid} = PledgeServer.start
send pid, {:stop, "hammertime"}

IO.inspect PledgeServer.create_pledge "larry", 10
#PledgeServer.clear()
IO.inspect PledgeServer.create_pledge "moe", 20
IO.inspect PledgeServer.create_pledge "curly", 30
IO.inspect PledgeServer.create_pledge "daisy", 40
IO.inspect PledgeServer.create_pledge "grace", 50

PledgeServer.set_cache_size(2)

IO.inspect PledgeServer.recent_pledges
IO.inspect PledgeServer.total_pledged

IO.inspect Process.info(pid, :messages)
