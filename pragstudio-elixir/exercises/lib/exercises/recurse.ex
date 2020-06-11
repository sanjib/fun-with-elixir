defmodule Exercises.Recurse do

  # -- sum

  def sum(list), do: sum(list, 0)

  def sum([head | tail], acc) do
    acc = head + acc
    sum(tail, acc)
  end

  def sum([], acc), do: acc

  # -- triple

  def triple([head | tail]) do
    [head * 3 | triple(tail)]
  end

  def triple([]), do: []

  # -- triple_tco: tail call optimized

  def triple_tco(list), do: triple_tco(list, [])

  def triple_tco([head | tail], acc) do
    acc = [head * 3 | acc]
    triple_tco(tail, acc)
  end

  def triple_tco([], acc), do: Enum.reverse acc

  # -- my_map

  def my_map(list, fun), do: my_map(list, fun, [])

  def my_map([], _fun, list), do: Enum.reverse(list)

  def my_map([head | tail], fun, list) do
    list = [fun.(head) | list]
    my_map(tail, fun, list)
  end

end