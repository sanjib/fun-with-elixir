defmodule Servy.Handler do
  require Logger

  def handle(request) do
    request
    |> parse
    |> log
    |> rewrite_path
    |> log
    |> route
    |> track
    |> emojify
    |> format_response
  end

  def track(conv = %{status: 404, path: path}) do
    Logger.info "--> It's lunchtime somewhere."
    Logger.warn "--> Do we have a problem, Houston?"
    Logger.error "--> Danger Will Robinson!"

    IO.puts "Warning: #{path} is on the loose!"
    conv
  end

  def track(conv), do: conv

#  def rewrite_path(conv = %{path: "/wildlife"}) do
#    %{conv | path: "/wildthings"}
#  end

#  def rewrite_path(conv = %{path: "/bears?id=" <> id}) do
#    %{conv | path: "/bears/#{id}"}
#  end

#  def rewrite_path(conv = %{path: ~r/(w+)\?id=(\d+)/}) do
#    %{conv | path: "/aaa/xxx"}
#  end

#  def rewrite_path(conv), do: conv

  def rewrite_path(conv = %{path: path}) do
    re = ~r/\/(?<thing>\w+)\?id=(?<id>\d+)/
    captures = Regex.named_captures(re, path)
    rewrite_path_captures(conv, captures)
  end

  def rewrite_path_captures(conv, %{"thing" => thing, "id" => id}) do
    %{conv | path: "/#{thing}/#{id}"}
  end

  def rewrite_path_captures(conv = %{path: "/wildlife"}, nil) do
    %{conv | path: "/wildthings"}
  end

  def rewrite_path_captures(conv, nil), do: conv

  def log(conv), do: IO.inspect(conv)

  def parse(request) do
    [method, path, _version] =
      request
      |> String.split("\n")
      |> List.first()
      |> String.split(" ")

    %{method: method, path: path, status: nil, resp_body: ""}
  end

#  def route(conv) do
#    route(conv, conv.method, conv.path)
#  end

  def route(conv = %{method: "GET", path: "/wildthings"}) do
    %{conv | status: 200, resp_body: "Bears, Lions, Tigers"}
  end

  def route(conv = %{method: "GET", path: "/bears"}) do
    %{conv | status: 200, resp_body: "Teddy, Smokey, Paddington"}
  end

  def route(conv = %{method: "GET", path: "/bears/" <> id}) do
    %{conv | status: 200, resp_body: "Bear #{id}"}
  end

  def route(conv = %{method: "DELETE", path: "/bears/" <> _id}) do
    %{conv | status: 403, resp_body: "Deleting a bear is forbidden!"}
  end

  def route(conv = %{path: path}) do
    %{conv | status: 404, resp_body: "No #{path} here!"}
  end

  def emojify(conv = %{status: 200}) do
    resp_body = """
    ( •̀ ω •́ )
    #{conv.resp_body}
    ( •̀ ω •́ )
    """
    %{conv | resp_body: resp_body}
  end

  def emojify(conv), do: conv

  def format_response(conv) do
    """
    HTTP/1.1 #{conv.status} #{status_reason(conv.status)}
    Content-Type: text/html
    Content-Length: #{byte_size(conv.resp_body)}

    #{conv.resp_body}
    ----------
    """
  end

  defp status_reason(code) do
    %{200 => "OK",
      201 => "Created",
      401 => "Unauthorized",
      403 => "Forbidden",
      404 => "Not Found",
      500 => "Internal Server Error"}[code]
  end
end


request = """
GET /wildthings HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""
response = Servy.Handler.handle(request)
IO.puts(response)


request = """
GET /bears HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""
response = Servy.Handler.handle(request)
IO.puts(response)


request = """
GET /bigfoot HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""
response = Servy.Handler.handle(request)
IO.puts(response)


request = """
GET /bears/1 HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""
response = Servy.Handler.handle(request)
IO.puts(response)


request = """
DELETE /bears/1 HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""
response = Servy.Handler.handle(request)
IO.puts(response)


request = """
GET /wildlife HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""
response = Servy.Handler.handle(request)
IO.puts(response)


request = """
GET /bears?id=1 HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""
response = Servy.Handler.handle(request)
IO.puts(response)

