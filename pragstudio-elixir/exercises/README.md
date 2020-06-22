# Exercises

- [Agents](./agents.md)
- [Application](./application.md)
- [Capture Functions](./capture_functions.md)
- [Capturing Expressions](./capturing_expressions.md)
- [Comprehensions](./comprehensions.md)
- [Concurrent, Isolated Processes](./concurrent_isolated_processes.md)
- [Elixir](./elixir.md)
- [GenServer](./gen_server.md)
- [HTTPoison](./httpoison.md)
- [Implementing Map](./implement_map.md)
- [Observer](./observer.md)
- [Process & System](process_and_system.md)
- [Recursion](./recursion.md)
- [sys](./sys.md)
- [Task](./task.md)
- [Test](./test.md)
- [Timer](./timer.md)

## Bookmarks

https://hexdocs.pm/elixir/patterns-and-guards.html#list-of-allowed-functions-and-operators

## Misc.

```console
mix run --no-halt
elixir --erl "-servy port 5000" -S mix run --no-halt
Application.put_env(:servy, :port, 5000)
mix new slurpie --sup
```

## Just for Fun

```console
iex> Enum.sum(1..10)    
55
iex> Enum.sum(1..100)   
5050
iex> Enum.sum(1..1_000)
500500
iex> Enum.sum(1..10_000)
50005000
```
