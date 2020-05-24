# Elixir for Programmers

Personal study notes and code for the course by Dave Thomas [Elixir for Programmers](https://codestool.coding-gnome.com/courses/elixir-for-programmers)

## Stack

- BEAM: the virtual machine (for example the JVM)
- OTP: collection of middleware, libraries and tools
- Erlang: the language (Elixir is transformed into Erlang to run on BEAM)
- Hex: package manager
- Mix: build tool
- IEx: interactive tool (REPL)
- Elixir: the language

## Links

- [Installing Elixir](https://elixir-lang.org/install.html)
- [Package manager Hex](https://hex.pm/), install `mix local.hex`

## Quotes

- Our main tools are functional composition and pattern matching.
- Composition means chaining together functions so that the output of one becomes the input of the next.
- Pattern matching lets you write different versions of the same function. This is similar to the idea of overloaded methods in some OO languages.
- When you're just starting out with Elixir, try to make yourself use pipelines all the time. A good way to remind yourself is to try not to use local variables. You won't always succeed—sometimes you just need to use them. But thinking about eliminating them will help you think in terms of transformations and pipelines.

## Notes

- Do we have elixir?

```console
> elixir -v
Erlang/OTP 21 [erts-10.3] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1]

Elixir 1.10.0 (compiled with Erlang/OTP 21)
```

- Install Hex `mix local.hex`
- Run IEx `iex`, on windows use `iex --werl`

### IEx

```console
> h IO.puts             # help for IO.puts
> h String.trim         # help for String.trim
> v 1                   # value for step 1
> (v 1) / 9             # divide value for step 1 by 9
> #iex:break            # break out of an entry
> r [module-name]       # recompile module
> c "lib/[src-file]"    # compile source file
```

- run iex from inside mix project directory `iex -S mix`

### mix

```console
mix new [project-name]  # create new project
mix                     # compile
mix run                 # run
mix run -e [mod].[fun]  # run mod.fun
mix help                # help
mix help run            # help for mix run
iex -S mix              # starts iex & runs default task
```
