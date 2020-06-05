defmodule Spawn3 do
  def greet do
    receive do
      {sender, msg} ->
        send sender, msg
        greet()
    end
  end
end

pid = spawn Spawn3, :greet, []
send pid, {self(), "hi"}

receive do
  msg ->
    IO.puts msg
end

send pid, {self(), "ho"}
receive do
  msg ->
    IO.puts msg
end
