# Processes

```elixir
defmodule Scratch.Procs do
  def greet(name) do
    Process.sleep(2000)
    IO.puts("Hello, #{name}")
  end
end
```

```console
iex> :observer.start()
greet = fn -> Process.sleep(1000); IO.puts("hello") end
Enum.each(1..100, fn _ -> spawn(greet) end)
iex> Enum.each(1..100, fn num -> spawn(Scratch.Procs, :greet, [num]) end)
:ok
Hello 82 Hello 1 Hello 2 Hello 87 Hello 3 Hello 89 Hello 91 Hello 94 Hello 4 Hello 96 Hello 5 Hello 99 Hello 6 Hello 37 Hello 7 Hello 39 Hello 8 Hello 40 Hello 38 Hello 9 Hello 42 Hello 46 Hello 44 Hello 48 Hello 10 Hello 50 Hello 52 Hello 11 Hello 56 Hello 12 Hello 57 Hello 59 Hello 13 Hello 54 Hello 61 Hello 14 Hello 65 Hello 15 Hello 63 Hello 67 Hello 16 Hello 70 Hello 69 Hello 17 Hello 71 Hello 72 Hello 18 Hello 73 Hello 75 Hello 74 Hello 76 Hello 19 Hello 77 Hello 78 Hello 20 Hello 80 Hello 79 Hello 21 Hello 81 Hello 22 Hello 84 Hello 23 Hello 83 Hello 85 Hello 24 Hello 86 Hello 25 Hello 90 Hello 26 Hello 88 Hello 92 Hello 27 Hello 93 Hello 28 Hello 95 Hello 97 Hello 98 Hello 29 Hello 100 Hello 31 Hello 30 Hello 33 Hello 34 Hello 32 Hello 36 Hello 41 Hello 45 Hello 43 Hello 47 Hello 51 Hello 49 Hello 53 Hello 35 Hello 55 Hello 58 Hello 60 Hello 66 Hello 62 Hello 68 Hello 64
```

```elixir
defmodule Scratch.Procs do
  def greet(hello) do
    receive do
      msg ->
        IO.puts("#{hello}, #{msg}")
    end

    greet(hello)
  end
end
```

```console
iex> pid = spawn Scratch.Procs, :greet, ["Hola"]
#PID<0.334.0>
iex> send pid, "mundo"
Hola, mundo
"mundo"
iex> send pid, "moon"
Hola, moon
"moon"
iex> send pid, "mars"
Hola, mars
"mars"
```

A background process maintaining its own state:

```elixir
defmodule Scratch.Procs do
  def greet(count) do
    receive do
      msg ->
        IO.puts("#{count}: Hello #{inspect(msg)}")
    end

    greet(count + 2)
  end
end
```

```console
iex> pid = spawn Procs, :greet, [0]
#PID<0.347.0>
iex> send pid, "mundo"
"mundo"
0: Hello "mundo"
iex(33)> send pid, "moon"
"moon"
2: Hello "moon"
iex(34)> send pid, "mars"
4: Hello "mars"
"mars"
```

```elixir
defmodule Scratch.Procs do
  def greet(count) do
    receive do
      {:add, num} ->
        greet(count + num)

      msg ->
        IO.puts("#{count}: Hello #{inspect(msg)}")
        greet(count)
    end
  end
end
```

```console
iex> pid = spawn Procs, :greet, [0]
#PID<0.358.0>
iex> send pid, "world"
0: Hello "world"
"world"
iex> send pid, {:add, 99}
{:add, 99}
iex> send pid, "world"
99: Hello "world"
"world"
```

```elixir
defmodule Scratch.Procs do
  def greet(count) do
    receive do
      {:add, num} ->
        greet(count + num)

      {:reset} ->
        greet(0)

      :reset ->
        greet(0)

      msg ->
        IO.puts("#{count}: Hello #{inspect(msg)}")
        greet(count)
    end
  end
end
```

```console
iex> send pid, "moon"
0: Hello "moon"
"moon"
iex> send pid, {:add, 42}
{:add, 42}
iex> send pid, "moon"
42: Hello "moon"
"moon"
iex> send pid, {:add, -2}
{:add, -2}
iex> send pid, "moon"
40: Hello "moon"
"moon"
iex> send pid, {:reset}
{:reset}
iex> send pid, "moon"
0: Hello "moon"
"moon"
iex> send pid, {:add, -2}
{:add, -2}
iex> send pid, "moon"
-2: Hello "moon"
"moon"
iex> send pid, :reset
:reset
iex> send pid, "moon"
0: Hello "moon"
"moon"
```

```elixir
defmodule Scratch.Procs do
  def greet(count) do
    receive do
      {:add, num} ->
        greet(count + num)

      :reset ->
        greet(0)

      {:die, reason} ->
        exit(reason)

      msg ->
        IO.puts("#{count}: hello #{msg}")
        greet(count)
    end
  end
end
```

```console
iex> pid = spawn_link Scratch.Procs, :greet, [42]
#PID<0.2223.0>
iex> send pid, "earth"
42: hello earth
"earth"
iex> send pid, {:die, :normal}
{:die, :normal}
iex> pid = spawn_link Scratch.Procs, :greet, [42]
#PID<0.2258.0>
iex> send pid, "earth"
42: hello earth
"earth"
iex> send pid, {:die, :abnormal}
** (EXIT from #PID<0.2105.0>) shell process exited with reason: :abnormal
```

```console
iex> {:ok, pid} = Agent.start_link(fn -> 0 end)
{:ok, #PID<0.4857.0>}
iex> Agent.get(pid, fn count -> count end)
0
iex> Agent.update(pid, fn count -> count+1 end)
:ok
iex> Agent.get(pid, fn count -> count end)
1
iex> Agent.get_and_update(pid, fn count -> {count, count+1} end)
1
iex> Agent.get_and_update(pid, fn count -> {count, count+1} end)
2
iex> Agent.get(pid, fn count -> count end)
3
```
