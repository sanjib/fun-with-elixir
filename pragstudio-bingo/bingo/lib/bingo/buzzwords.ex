defmodule Bingo.Buzzwords do
  @moduledoc false

  alias Bingo.{Square}

  def read_buzzwords() do
    Path.absname("data")
    |> Path.join("buzzwords.csv")
    |> File.read!
    |> String.trim
    |> String.split("\n")

  end

end
