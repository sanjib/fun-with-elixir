defmodule Exercises.Recurse do
  def sum(list), do: sum(list, 0)

  def sum([head | tail], acc) do
    acc = head + acc
    sum(tail, acc)
  end

  def sum([], acc), do: acc

  # --

  def triple([head | tail]) do
    [head * 3 | triple(tail)]
  end

  def triple([]), do: []

  # -- tco: tail call optimized

  def triple_tco(list), do: triple_tco(list, [])

  def triple_tco([head | tail], acc) do
    acc = [head * 3 | acc]
    triple_tco(tail, acc)
  end

  def triple_tco([], acc), do: Enum.reverse acc
end