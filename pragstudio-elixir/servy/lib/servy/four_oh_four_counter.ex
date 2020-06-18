defmodule Servy.FourOhFourCounter do

  @name __MODULE__

  #-----------------------------------------------
  # Client:

  def start(init_state \\ %{}) do
    IO.puts "Starting Four Oh Four Counter..."
#    pid = spawn(__MODULE__, :listen_loop, [%{}])
    pid = spawn(fn -> listen_loop(init_state) end)
    Process.register(pid, @name)
    pid
  end

  def bump_count(path) do
    send @name, {self(), :bump_count, path}
    receive do {:response, message} -> message end
  end

  def get_count(path) do
    send @name, {self(), :get_count, path}
    receive do {:response, count} -> count end
  end

  def get_counts() do
    send @name, {self(), :get_counts}
    receive do {:response, state} -> state end
  end

  #-----------------------------------------------
  # Server:

  def listen_loop(state) do
    receive do
      {sender, :bump_count, path} ->
        count =
          state
          |> Map.get(path)
          |> inc_bump_count
        new_state = Map.new(state)
        new_state = Map.put(new_state, path, count)
        send sender, {:response, "#{path} count is #{count}"}
        listen_loop(new_state)

      {sender, :get_count, path} ->
        count = Map.get(state, path)
        send sender, {:response, count}
        listen_loop(state)

      {sender, :get_counts} ->
        send sender, {:response, state}
        listen_loop(state)
    end
  end

  defp inc_bump_count(nil), do: 1
  defp inc_bump_count(val), do: val + 1

end
