defmodule CoreTest do
  use ExUnit.Case
  import Calculator.Core

  test "add" do
    assert add(10, 5) == 15
  end
  
  test "subtract" do
    assert subtract(10, 5) == 5
  end

  test "multiply" do
    assert multiply(10, 5) == 50
  end

  test "divide" do
    assert divide(10, 5) === 2.0
  end

  test "fold" do
    assert fold([1, 2, 3], 0, fn acc, x -> acc + x end) == 6
  end

end