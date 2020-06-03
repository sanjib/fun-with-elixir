defmodule Calculator.Core do
  def add(acc, num),      do: acc + num
  def subtract(acc, num), do: acc - num
  def multiply(acc, num), do: acc * num
  def divide(acc, num),   do: acc / num

  def fold(list, acc, fun) do
    Enum.reduce(list, acc, fn x, acc -> fun.(acc, x) end)
  end
end
