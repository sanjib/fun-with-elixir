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
