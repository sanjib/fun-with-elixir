defmodule Chain do
  def counter(pid) do
    receive do
      n ->
        # IO.inspect pid
        send pid, n + 1
    end
  end

  def create_ps(n) do
    fun = fn (_, pid) -> spawn(Chain, :counter, [pid]) end
    pid_n = Enum.reduce(1..n, self(), fun)
    send(pid_n, 0)
    
    receive do
      n_inc when is_integer(n_inc) ->
        "Result is #{n_inc}"
    end
  end

  def run(n) do
    # :timer.tc create_ps(n) 
    :timer.tc(Chain, :create_ps, [n])
    |> IO.inspect
  end
end

# Chain.run(100_000)
# elixir --erl "+P 1000000" -r chain.exs -e "Chain.run(400_000)"
# elixir --erl "+P 1000000" -r chain.exs -e "Chain.run(1_000_000)"
