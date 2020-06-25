defmodule Bingo.Square do
  @moduledoc false

  alias Bingo.{Square}

  defstruct [
    phrase: nil,
    points: 0,
    marked_by: nil,
  ]

  def new(buzzword) when is_binary(buzzword) do
    [phrase, points] = String.split(buzzword, ",")
    %Square{phrase: phrase, points: String.to_integer(points)}
  end

  def update_phrase(%Square{} = square, phrase, player) do
    cond do
      square.phrase == phrase ->
        %{square | marked_by: player}
      true -> square
    end
  end

end
