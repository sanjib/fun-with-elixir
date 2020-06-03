defmodule Calculator do
  alias Calculator.Boundary

   def start(initial_state) do
     Boundary.start(initial_state)
   end

   def add(calc, n),      do: send(calc, {:add, n})
   def subtract(calc, n), do: send(calc, {:subtract, n})
   def multiply(calc, n), do: send(calc, {:multiply, n})
   def divide(calc, n),   do: send(calc, {:divide, n})

   def custom(calc, fun, num), do: send(calc, {:custom, fun, num})
   def clear(calc), do: send(calc, :clear)

   def state(calc) do
    send(calc, {:state, self()})
    receive do
      {:state, state} -> state
    after
      5000 -> {:error, :timeout}
    end
   end
end
