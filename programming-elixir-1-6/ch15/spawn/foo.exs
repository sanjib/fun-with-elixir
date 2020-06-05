defmodule Foo do
  def bar do
    # IO.puts "bar"
    "bar"
  end
end

pid = spawn Foo, :bar, []

