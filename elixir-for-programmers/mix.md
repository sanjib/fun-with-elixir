# mix

```console
mix new [prj-name]      # create new project
mix new [prj-name] --sup # create new project as application or top-level supervisor
mix                     # compile
mix run                 # run
mix run -e [mod].[fun]  # run function in module name
mix help                # help
mix help run            # help for mix run
iex -S mix              # starts iex & runs default task
mix deps.get            # fetch deps
mix hex.search [pkgs]   # search for packages in hex.pm
mix test                # run tests
mix clean
mix compile
mix do clean, compile
mix archive             # list installed archives
mix phx.new [prj] --no-ecto # install new phoenix project without ecto database mappying layer
```

Examples:
```console
mix phx.new gallows --no-ecto
```
