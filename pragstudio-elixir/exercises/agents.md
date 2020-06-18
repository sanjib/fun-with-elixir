# Agents

- start
- update
- get

```console
iex> {:ok, agent} = Agent.start(fn -> [] end)
{:ok, #PID<0.32411.4>}
iex> Agent.get(agent, fn state -> state end)
[]
iex> Agent.update(agent, fn state -> [{"larry", 10} | state] end)
:ok
iex> Agent.get(agent, fn state -> state end)
[{"larry", 10}]
iex> Agent.update(agent, fn state -> [{"moe", 20} | state] end)
:ok
iex> Agent.get(agent, fn state -> state end)
[{"moe", 20}, {"larry", 10}]
iex> Agent.update(agent, fn state -> [{"curly", 30} | state] end)
:ok
iex> Agent.get(agent, fn state -> state end)
[{"curly", 30}, {"moe", 20}, {"larry", 10}]
```

