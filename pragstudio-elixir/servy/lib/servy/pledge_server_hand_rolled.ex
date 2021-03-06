defmodule Servy.GenericServerHandRolled do

  def start(callback_module, initial_state, name) do
    pid = spawn(__MODULE__, :listen_loop, [initial_state, callback_module])
    Process.register(pid, name)
    pid
  end

  def call(pid, message) do
    send pid, {:call, self(), message}
    receive do {:response, response} -> response end
  end

  def cast(pid, message) do
    send pid, {:cast, message}
  end

  def listen_loop(state, callback_module) do

    receive do
      {:call, sender, message} when is_pid(sender) ->
        # IO.puts "--> message: #{inspect message}"
        {response, new_state} = callback_module.handle_call(message, state)
        send sender, {:response, response}
        listen_loop(new_state, callback_module)

      {:cast, message} ->
        new_state = callback_module.handle_cast(message, state)
        listen_loop(new_state, callback_module)

      message ->
        # IO.puts "--> unexpected msg: #{inspect unexpected}"
        {:noreply, new_state} = callback_module.handle_info(message, state)
        listen_loop(new_state, callback_module)
    end
  end
end

defmodule Servy.PledgeServerHandRolled do
  alias Servy.GenericServerHandRolled

#  @name :pledge_server
  @name __MODULE__

  #________________________________________________
  # Client interface

  def start() do
    IO.puts "Starting the pledge server..."
    GenericServerHandRolled.start(__MODULE__, [], @name)
  end

  def create_pledge(name, amount) do
    GenericServerHandRolled.call @name, {:create_pledge, name, amount}
    # send @name, {self(), :create_pledge, name, amount}
    # receive do {:response, status} -> status end
  end

  def recent_pledges() do
    GenericServerHandRolled.call @name, :recent_pledges
    # send @name, {self(), :recent_pledges}

    # receive is a blocking call
    # so the function recent_pledges as a whole
    # is synchronous
    # receive do {:response, pledges} -> pledges end
  end

  def total_pledged() do
    GenericServerHandRolled.call @name, :total_pledged
    # send @name, {self(), :total_pledged}
    # receive do {:response, total} -> total end
  end

  def clear() do
    GenericServerHandRolled.cast @name, :clear
  end

  #________________________________________________
  # Server Callbacks

  def handle_cast(:clear, _state), do: []

  def handle_call({:create_pledge, name, amount}, state) do
    {:ok, id} = send_pledge_to_service(name, amount)
    most_recent_pledges = Enum.take(state, 2)
    new_state = [{name, amount} | most_recent_pledges]
    {id, new_state}
  end

  def handle_call(:recent_pledges, state), do: {state, state}

  def handle_call(:total_pledged, state) do
    # total = Enum.reduce(state, 0, fn {_name, amount}, acc -> amount + acc  end)
    total = Enum.map(state, &elem(&1, 1)) |> Enum.sum
    {total, state}
  end

  def handle_info(message, state) do
    IO.puts "--> handle_info: #{inspect message}"
    {:noreply, state}
  end

  defp send_pledge_to_service(_name, _amount) do
    {:ok, "pledge-#{:rand.uniform(1000)}"}
  end
end

#alias Servy.PledgeServerHandRolled
#pid = PledgeServerHandRolled.start
#
#send pid, {:stop, "hammertime"}
#IO.inspect PledgeServerHandRolled.create_pledge "larry", 10
#IO.inspect PledgeServerHandRolled.create_pledge "moe", 20
#IO.inspect PledgeServerHandRolled.create_pledge "curly", 30
#IO.inspect PledgeServerHandRolled.create_pledge "daisy", 40
#
#PledgeServerHandRolled.clear()
#
#IO.inspect PledgeServerHandRolled.create_pledge "grace", 50
#
#IO.inspect PledgeServerHandRolled.recent_pledges
#IO.inspect PledgeServerHandRolled.total_pledged
#
#IO.inspect Process.info(pid, :messages)
