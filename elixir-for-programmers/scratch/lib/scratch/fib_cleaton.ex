# Credits: https://github.com/cleaton
defmodule Scratch.FibCleaton do
  def fib(n) do
    {:ok, a} = Agent.start_link(fn -> %{0 => 0, 1 => 1} end)
    fib(a, n)
  end

  defp fib(agent, n) do
    fib(agent, n, Agent.get(agent, &Map.get(&1, n)))
  end

  defp fib(agent, n, nil) do
    v = fib(agent, n - 1) + fib(agent, n - 2)
    Agent.update(agent, &Map.put(&1, n, v))
    v
  end

  defp fib(agent, n, value) do
    value
  end
end
