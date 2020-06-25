defmodule Bingo.Player do
  @moduledoc false

  alias Bingo.{Player}

  defstruct [
    name: nil,
    color: nil,
  ]

  def new(name, color) do
    %Player{name: name, color: color}
  end

end
