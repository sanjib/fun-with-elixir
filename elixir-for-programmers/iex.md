# IEx

```console
> h IO.puts             # help for IO.puts
> h String.trim         # help for String.trim
> v 1                   # value for step 1
> (v 1) / 9             # divide value for step 1 by 9
> #iex:break            # break out of an entry
> r [module-name]       # recompile module, must have been compiled at least once
> c "lib/[src-file]"    # compile source file, use for new files
```

- run IEx `iex`, on windows use `iex --werl`
- run iex from inside mix project directory `iex -S mix`
