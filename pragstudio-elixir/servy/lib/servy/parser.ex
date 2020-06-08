defmodule Servy.Parser do
  @doc "Parses a request and returns a map with keys: method, path, status, resp_body."

  alias Servy.Conv

  def parse(request) do
    [top, params_str] = String.split(request, "\n\n")
    [request_line | header_lines ] = String.split(top, "\n")
    [method, path, _version] = String.split(request_line, " ")
    params = parse_params(params_str)

    %Conv{method: method, path: path, params: params}
  end

  def parse_params(params_str) do
    params_str
    |> String.trim
    |> URI.decode_query
  end
end