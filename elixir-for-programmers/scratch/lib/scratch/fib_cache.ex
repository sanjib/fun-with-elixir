defmodule Scratch.FibCache do
  def init() do
    Agent.start_link(fn -> %{0 => 0, 1 => 1} end)
  end

  def add(agent, key, val) do
    Agent.update(agent, fn state -> Map.put(state, key, val) end)
  end

  def get(agent, key) do
    Agent.get(agent, fn state -> Map.get(state, key) end)
  end

  def get(agent) do
    Agent.get(agent, fn state -> state end)
  end
end
