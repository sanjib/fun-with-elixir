# Supervisor

- Supervisor.which_children
- Supervisor.count_children

Configuring children 

```elixir
def init(:ok) do
  children = [
    Servy.PledgeServer,
    {Servy.SensorServer, 60},
  ]
  Supervisor.init(children, strategy: :one_for_one)
end
```

```elixir
children = [
  Servy.PledgeServer,
  {Servy.SensorServer, interval: 60, target: "bigfoot"}
]

def start_link(options) do
  interval = Keyword.get(options, :interval)
  target = Keyword.get(options, :target)
  ...
end
```

Overriding child spec fields

```elixir
use GenServer, restart: :temporary
use GenServer, start: {__MODULE__, :start_link, [60]}, restart: :temporary
def child_spec(arg) do
  %{
    id: __MODULE__,
    start: {__MODULE__, :start_link, [arg]},
    restart: :permanent,
    shutdown: 5000,
    type: :worker
  }
end
def child_spec(:frequent) do
  %{
    id: __MODULE__,
    start: {__MODULE__, :start_link, [1]},
    restart: :permanent,
    shutdown: 5000,
    type: :worker
  }
end

def child_spec(:infrequent) do
  %{
    id: __MODULE__,
    start: {__MODULE__, :start_link, [60]},
    restart: :permanent,
    shutdown: 5000,
    type: :worker
  }
end

def child_spec(_) do
  %{
    id: __MODULE__,
    start: {__MODULE__, :start_link, []},
    restart: :permanent,
    shutdown: 5000,
    type: :worker
  }
end
children = [
  Servy.PledgeServer,
  {Servy.SensorServer, :frequent}
]
children = [
  Servy.PledgeServer,
  {Servy.SensorServer, :infrequent}
]
```

Child specification fields

- :id
- :start
- :restart
- :shutdown
- :type

Restart strategies

- :one_for_one
- :one_for_all
- :rest_for_one
- :simple_one_for_one
- :max_restarts
- :max_seconds

