defmodule Servy.Handler do
  @moduledoc "Handles HTTP requests."
  @about_file_path "../../pages/about.html"
  @form_file_path "../../pages/form.html"

  alias Servy.Plugins
  alias Servy.Parser
  alias Servy.FileHandler
  alias Servy.Conv
  alias Servy.BearController

  @doc "Transforms the request into a response."
  def handle(request) do
    request
    |> Parser.parse
    |> Plugins.log
    |> Plugins.rewrite_path
#    |> Plugins.log
    |> route
    |> Plugins.track
#    |> emojify
    |> format_response
  end

  @doc ""
  def route(conv = %Conv{method: "GET", path: "/wildthings"}) do
    %{conv | status: 200, resp_body: "Bears, Lions, Tigers"}
  end

  def route(conv = %Conv{method: "GET", path: "/bears"}) do
    BearController.index(conv)
  end

  def route(conv = %Conv{method: "POST", path: "/bears"}) do
    BearController.create(conv, conv.params)
  end

  def route(conv = %Conv{method: "GET", path: "/bears/new"}) do
    FileHandler.file_read(@form_file_path, conv)
  end

  def route(conv = %Conv{method: "GET", path: "/bears/" <> id}) do
    params = Map.put(conv.params, "id", id)
    BearController.show(conv, params)
  end

  def route(conv = %Conv{method: "DELETE", path: "/bears/" <> _id}) do
    BearController.delete(conv, conv.params)
  end

  def route(conv = %Conv{method: "GET", path: "/about"}) do
    FileHandler.file_read(@about_file_path, conv)
  end

  def route(conv = %Conv{method: "GET", path: "/pages/" <> page_name}) do
    FileHandler.file_read("../../pages/#{page_name}.html", conv)
  end

  def route(conv = %Conv{path: path}) do
    %{conv | status: 404, resp_body: "No #{path} here!"}
  end

  @doc ""
  def emojify(conv = %Conv{status: 200}) do
    resp_body = """
    <*)))<
    #{conv.resp_body}
    <*)))<
    """
    %{conv | resp_body: resp_body}
  end

  def emojify(%Conv{} = conv), do: conv

  def format_response(%Conv{} = conv) do
    """
    HTTP/1.1 #{Conv.full_status(conv)}\r
    Content-Type: text/html\r
    Content-Length: #{byte_size(conv.resp_body)}\r
    \r
    #{conv.resp_body}
    """
  end
end

