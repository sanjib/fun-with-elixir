# Concurrent, Isolated Processes

Two ways to spawn

- `spawn(fn() -> serve(client_socket) end)`
- MFA (module, function, arguments): `spawn(Servy.HttpServer, :start, [4000])`

### Spawn 10,000 processes

```console
iex> Enum.each(1..10_000, fn num -> spawn(fn -> IO.puts num*num end) end)
```
