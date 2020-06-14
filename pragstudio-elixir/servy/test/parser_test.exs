defmodule ParserTest do
  use ExUnit.Case, async: true

  alias Servy.Parser

  test "parses a list of header fields into a map: [a b] -> {a: b}" do
    header_lines = ["A: 1", "B: 2"]
    headers = Parser.parse_headers(header_lines)

    assert headers == %{"A" => "1", "B" => "2"}

  end
end