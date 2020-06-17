power_nap = fn ->
  time = :rand.uniform(10_000)
  :timer.sleep(time)
  time
end

parent = self()
spawn(fn -> send(parent, {:slept, power_nap.()}) end)
time_slept = receive do {:slept, time} -> time end

IO.puts("Slept #{time_slept} ms")
