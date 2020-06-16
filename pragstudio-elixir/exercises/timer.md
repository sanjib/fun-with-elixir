# Timer

`:timer.sleep(:infinity)` when run at the bottom of an Elixir code file will not let the Elixir VM exit

The alternative is to use `--no-halt` which will keep alive the elixir execution. For example:

`elixir --no-halt timer.ex`

will not let the Erlang VM exit

