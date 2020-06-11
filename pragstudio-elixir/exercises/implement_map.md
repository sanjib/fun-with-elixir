# Implement map

```elixir
def my_map(list, fun), do: my_map(list, fun, [])

def my_map([], _fun, list), do: Enum.reverse(list)

def my_map([head | tail], fun, list) do
  list = [fun.(head) | list]
  my_map(tail, fun, list)
end
```

```console
iex> Exercises.Recurse.my_map([1, 2, 3], &(&1 *2))
[2, 4, 6]
iex> Exercises.Recurse.my_map([1, 2, 3], &(&1 *4)) 
[4, 8, 12]
iex> Exercises.Recurse.my_map([1, 2, 3], &(&1 *5))
[5, 10, 15]

```