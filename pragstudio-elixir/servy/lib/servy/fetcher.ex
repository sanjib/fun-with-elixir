defmodule Servy.Fetcher do

#  alias Servy.VideoCam

  def async(fun) do
    parent = self()
    spawn(fn -> send(parent, {self(), :result, fun.()}) end)
  end

  def get_result(pid) do
    receive do
      {^pid, :result, value} -> value
    after 2000 ->
      raise "Timed out!"
    end
  end

  def get_result() do
    receive do
      {_, :result, value} -> value
    after 2000 ->
      raise "Timed out!"
    end
  end

end
