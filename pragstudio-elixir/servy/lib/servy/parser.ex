defmodule Servy.Parser do
  @doc "Parses a request and returns a map with keys: method, path, status, resp_body."

  alias Servy.Conv

  def parse(request) do
    [method, path, _version] =
      request
      |> String.split("\n")
      |> List.first()
      |> String.split(" ")

    %Conv{method: method, path: path}
  end
end