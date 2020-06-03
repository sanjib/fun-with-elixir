defmodule Calculator.Boundary do
  alias Calculator.Core 

  def start(initial_state) do
    spawn fn -> run(initial_state) end
  end

  def run(state) do
    state
    |> listen
    |> run
  end

  def listen(state) do
    receive do
      {:add, num}      -> Core.add(state, num)
      {:subtract, num} -> Core.subtract(state, num)
      {:multiply, num} -> Core.multiply(state, num)
      {:divide, num}   -> Core.divide(state, num)
      {:clear}         -> 0
      {:state, pid}    -> send(pid, {:state, state}); state
    end
  end

end
