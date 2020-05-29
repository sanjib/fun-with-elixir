# IEx

```console
iex> h IO.puts             # help for IO.puts
iex> h String.trim         # help for String.trim
iex> v 1                   # value for step 1
iex> (v 1) / 9             # divide value for step 1 by 9
iex> #iex:break            # break out of an entry
iex> r [module-name]       # recompile module, must have been compiled at least once
iex> c "lib/[src-file]"    # compile source file, use for new files
```

Only for development, experiment:

```console
iex> Node.connect(:one@SANTPT480) # where "one" is the short name and "SANTPT480" is the host name
iex> Node.list()           # list connected nodes
iex> node()                # name of current node
iex> Node.spawn :two@SANTPT480, fn -> IO.puts "hello two" end
iex> pid = spawn Scratch.DemoNodes, :reverse, []
iex> send pid, "hello"
iex> Process.register(pid, :rev) # name a process with pid
iex> send :rev, "hello"
iex> send {:rev, :two@SANTPT480}, "remote"
iex(two@SANTPT480)> Process.register(pid, :rev1)
true
iex(two@SANTPT480)> send :rev1, {self(), "reverse"}
{#PID<0.110.0>, "reverse"}
iex(two@SANTPT480)> flush()
"esrever"
:ok
iex(one@SANTPT480)> send {:rev1, :two@SANTPT480}, {self(), "again"}
{#PID<0.110.0>, "again"}
iex(one@SANTPT480)> flush()
"niaga"
:ok
```

```console
iex(two@SANTPT480)13> r Scratch.DemoNodes                        
{:reloaded, Scratch.DemoNodes, [Scratch.DemoNodes]}
iex(two@SANTPT480)14> pid = spawn Scratch.DemoNodes, :reverse, []
#PID<0.150.0>
iex(two@SANTPT480)15> Process.register(pid, :rev2)               
true
iex(two@SANTPT480)16> send :rev2, {self(), "reverse"}            
#PID<0.110.0>
{#PID<0.110.0>, "reverse"}
iex(two@SANTPT480)17> flush()
"esrever"
:ok
iex(one@SANTPT480)9> send {:rev2, :two@SANTPT480}, {self(), "again"}
{#PID<0.110.0>, "again"}
iex(one@SANTPT480)10> flush()
"niaga"
:ok

```

- run IEx `iex`, on windows use `iex --werl`
- run iex from inside mix project directory `iex -S mix`
- run iex with short name `iex --sname one`
