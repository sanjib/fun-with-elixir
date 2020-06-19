defmodule Servy.FourOhFourCounter.GenericServer do

  def start(callback_module, init_state, name) do
    pid = spawn(fn -> listen_loop(init_state, callback_module) end)
    Process.register(pid, name)
    pid
  end

  def call(pid, message) do
    send pid, {:call, self(), message}
    receive do {:response, response} -> response end
  end

  def listen_loop(state, callback_module) do
    receive do
      {:call, sender, message} when is_pid(sender) ->
        {response, new_state} = callback_module.handle_call(message, state)
        send sender, {:response, response}
        listen_loop(new_state, callback_module)

      {:cast, message} ->
        new_state = callback_module.handle_cast(message, state)
        listen_loop(new_state, callback_module)

      unexpected ->
        IO.puts "Unexpected messaged: #{inspect unexpected}"
        listen_loop(state, callback_module)
    end
  end
end

defmodule Servy.FourOhFourCounter do

  alias Servy.FourOhFourCounter.GenericServer

  @name __MODULE__

  #-----------------------------------------------
  # Client:

  def start(init_state \\ %{}) do
    GenericServer.start(__MODULE__, init_state, @name)
  end

  def bump_count(path) do
     GenericServer.call(@name, {:bump_count, path})
  end

  def get_count(path) do
    GenericServer.call(@name, {:get_count, path})
  end

  def get_counts() do
    GenericServer.call(@name, :get_counts)
  end

  #--

  def handle_call({:bump_count, path}, state) do
    count =
      state
      |> Map.get(path)
      |> inc_bump_count
    new_state = Map.new(state)
    new_state = Map.put(new_state, path, count)
    {count, new_state}
  end

  def handle_call({:get_count, path}, state) do
    count = Map.get(state, path)
    {count, state}
  end

  def handle_call(:get_counts, state), do: {state, state}

  defp inc_bump_count(nil), do: 1
  defp inc_bump_count(val), do: val + 1

end
