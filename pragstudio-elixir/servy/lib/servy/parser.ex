defmodule Servy.Parser do
  @doc "Parses a request and returns a map with keys: method, path, status, resp_body."

  alias Servy.Conv

  def parse(request) do
    [top, params_str] = String.split(request, "\n\n")
    [request_line | header_lines ] = String.split(top, "\n")
    [method, path, _version] = String.split(request_line, " ")
#    headers = parse_headers(header_lines, %{})
    headers = parse_headers(header_lines)
    params = parse_params(headers["Content-Type"], params_str)

    %Conv{method: method,
          headers: headers,
          path: path,
          params: params}
  end

#  def parse_headers([head | tail], headers) do
#    [key, val] = String.split(head, ": ")
#    headers = Map.put(headers, key, val)
#    parse_headers(tail, headers)
#  end
#
#  def parse_headers([], headers), do: headers

  def parse_headers(header_lines) do
    Enum.reduce(header_lines, %{}, fn header_line, headers ->
      [key, val] = String.split(header_line, ": ")
      Map.put(headers, key, val)
    end)
  end

  # --

  def parse_params("application/x-www-form-urlencoded", params_str) do
    params_str
    |> String.trim
    |> URI.decode_query
  end

  def parse_params(_, _), do: %{}

end