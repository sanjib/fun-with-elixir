# Test

- run all the test cases `mix test`
- run multiple test cases
```console
mix test test/parser_test.exs test/handler_test.exs
```
- run a specific test
```console
mix test test/servy_test.exs
```
- run a specific test for a specific line (line number can be found in test fail output)
```console
mix test test/parser_test.exs:7
```

- run tests async (speeds up when many tests)
```console
use ExUnit.Case, async: true
```

- organize doctest
```elixir

```