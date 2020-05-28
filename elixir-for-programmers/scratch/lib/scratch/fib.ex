defmodule Scratch.Fib do
  def fib_old(0), do: 0
  def fib_old(1), do: 1
  def fib_old(n), do: fib_old(n - 1) + fib_old(n - 2)

  def init() do
    {:ok, agent} = Scratch.FibCache.init()
    agent
  end

  def fib(agent, 0), do: Scratch.FibCache.get(agent, 0)
  def fib(agent, 1), do: Scratch.FibCache.get(agent, 1)

  def fib(agent, n) do
    key1 = n - 1
    key2 = n - 2
    val1 = Scratch.FibCache.get(agent, key1)
    val2 = Scratch.FibCache.get(agent, key2)
    fib_vals(agent, {key1, val1}, {key2, val2})
  end

  def fib_vals(agent, {key1, nil}, {key2, nil}) do
    Scratch.FibCache.add(agent, key1, fib(agent, key1))
    Scratch.FibCache.add(agent, key2, fib(agent, key2))
    Scratch.FibCache.get(agent, key1) + Scratch.FibCache.get(agent, key2)
  end

  def fib_vals(agent, {key1, nil}, {_key2, val2}) do
    Scratch.FibCache.add(agent, key1, fib(agent, key1))
    Scratch.FibCache.get(agent, key1) + val2
  end

  def fib_vals(_agent, {_key1, val1}, {_key2, val2}) do
    val1 + val2
  end
end
