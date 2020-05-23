# Elixir for Programmers

## Stack

- BEAM: the virtual machine (for example the JVM)
- OTP: collection of middleware, libraries and tools
- Erlang: the language (Elixir is transformed into Erlang to run on BEAM)
- Hex: package manager
- Mix: build tool
- IEx: interactive tool (REPL)
- Elixir: the language 

## Links

- Installing Elixir https://elixir-lang.org/install.html
- Package manager Hex, install `mix local.hex` https://hex.pm/

## Notes

- Do we have elixir?
<pre>
>elixir -v
Erlang/OTP 21 [erts-10.3] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1]

Elixir 1.10.0 (compiled with Erlang/OTP 21)
</pre>

- Install Hex `mix local.hex`
- Run IEx `iex`, on windows use `iex --werl`

### IEx
<pre>
> h IO.puts             # help for IO.puts
> h String.trim         # help for String.trim
> v 1                   # value for step 1
> (v 1) / 9             # divide value for step 1 by 9
> #iex:break            # break out of an entry
</pre>

### mix

- new projects
<pre>
mix new [project-name]
</pre>