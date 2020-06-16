# Elixir

`--no-halt`: will keep alive the elixir execution. For example:

`elixir --no-halt timer.ex`

will not let the Erlang VM exit

The alternative is to run `:timer.sleep(:infinity)` at the bottom of the file.
