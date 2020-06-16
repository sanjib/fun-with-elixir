defmodule Timer do

  def remind(subject, time_secs) do
    spawn(fn -> :timer.sleep(time_secs * 1000); IO.puts subject end)
  end

  def run_examples() do
    Timer.remind("Stand Up", 5)
    Timer.remind("Sit Down", 10)
    Timer.remind("Fight, Fight, Fight", 15)
  end

end

Timer.run_examples()
#:timer.sleep(:infinity)