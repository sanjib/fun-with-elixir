# GenServer

Callback functions:

**1. handle_call(message, from, state)**

- synchronous
- from arg {pid, tag} is usually ignored
- default implementation returns `{:stop, {:bad_call, msg}, state}` and stops the server

```elixir
@name __MODULE__

def some_action(arg1, arg2) do
  GenServer.call @name, {:some_action, arg1, arg2}
  # returns some_response from handle_call
end

def handle_call({:some_action, arg1, arg2}, _from, state) do
  # code...
  {:reply, some_response, new_state}
end
```


**2. handle_cast(message, state)**

- asynchronous
- to stop server, return `{:stop, reason, new_state}`
- default implementation returns `{:stop, {:bad_cast, msg}, state}` and stops the server

```elixir
@name __MODULE__

def some_action(arg1, arg2) do
  GenServer.cast @name, {some_action, arg1, arg2}
end

def handle_cast({:some_action, arg1, arg2}, state) do
  # code ...
  {:noreply, new_state}
end
```

**3. handle_info(message, state)**

- invoked to handle all requests that are not call or cast, for example: `send pid, {:some_action, arg1}`
- `handle_info({:some_action, arg1}, state), do: {:noreply, state}`
- default implementation logs message and returns `{:noreply, state}`

**4. init(init_args)**

- automatically called with state
- start will block until init returns

```elixir
def init(state) do
  # code...
  {:ok, new_state}
end
```

**5. terminate(reason, state)**

- invoked when server is about to terminate
- allows cleanup (close resources, save state to disk)
- terminate doesn't always get called in some situations
- so better to use supervisor

```elixir
def terminate(_reason, _state) do
  :ok
end
```

**6. code_change(old_version, state, extra)**

- hot code-swapping
- allows state migration
- https://hexdocs.pm/elixir/GenServer.html#callbacks

## Call Timeout

- GenServer.call is synchronous
- defaults 5 seconds
- override by passing 3rd arg
- `GenServer.call @name, message, 2000`
