defmodule UserApiTest do
  use ExUnit.Case, async: true

  test "get valid user city" do
    result = case UserApi.query("1") do
      {:ok, city} -> city
      {:error, error} -> error
    end
    assert result == "Gwenborough"
  end

#  test "get invalid user city" do
#    result = case UserApi.query("xxx") do
#      {:ok, city} -> city
#      {:error, error} -> error
#    end
#    assert result == :timeout
#  end
end
