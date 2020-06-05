defmodule Servy.Parser do
  @doc "Parses a request and returns a map with keys: method, path, status, resp_body."
  def parse(request) do
    [method, path, _version] =
      request
      |> String.split("\n")
      |> List.first()
      |> String.split(" ")

    %{method: method, path: path, status: nil, resp_body: ""}
  end
end