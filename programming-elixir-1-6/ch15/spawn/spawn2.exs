defmodule Spawn2 do
  def greet do
    receive do
      {sender, msg} ->
        send sender, {:ok, msg}
    end
  end
end

pid = spawn Spawn2, :greet, []
send pid, {self(), "ping"}
receive do
  {:ok, msg} ->
    IO.puts msg
end

# pid = spawn Spawn2, :greet, []
send pid, {self(), "pong"}
receive do
  {:ok, msg} ->
    IO.puts msg
after
  2000 ->
    IO.puts "nothing received"
end
