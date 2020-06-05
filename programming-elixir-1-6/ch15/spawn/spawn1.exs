defmodule Spawn1 do
  def greet do
    receive do
      {sender, msg} ->
      send sender, {:ok, "Hello, #{msg}"}
    end
  end
end

# a client
pid = spawn Spawn1, :greet, []
send pid, {self(), "world!"}

receive do
  {:ok, msg} ->
    IO.puts msg
end
