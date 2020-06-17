defmodule Servy.Handler do
  @moduledoc "Handles HTTP requests."
  @about_file_path "../../pages/about.html"
  @form_file_path "../../pages/form.html"
  @faq_bigfoot_file_path "../../pages/faq-bigfoot.md"

  alias Servy.Plugins
  alias Servy.Parser
  alias Servy.FileHandler
  alias Servy.Conv
  alias Servy.BearController
  alias Servy.VideoCam
  alias Servy.Fetcher
#  alias Servy.View
  import Servy.View, only: [render: 3]

  @doc "Transforms the request into a response."
  def handle(request) do
    request
    |> Parser.parse
#    |> Plugins.log
    |> Plugins.rewrite_path
#    |> Plugins.log
    |> route
    |> Plugins.track
#    |> emojify
    |> Servy.Conv.put_content_length
    |> format_response
  end

  @doc ""

  def route(conv = %Conv{method: "GET", path: "/api/bears"}) do
    Servy.Api.BearController.index(conv)
  end

  def route(conv = %Conv{method: "GET", path: "/api/sensors"}) do

#    locations =
#      ["bigfoot", "roscoe", "brutus", "smokey"]
#      |> Enum.map(&Fetcher.async(fn -> Servy.Tracker.get_location(&1) end))
#      |> Enum.map(&Fetcher.get_result/1)

    data =
      ["bigfoot", "roscoe", "brutus", "smokey"]
#      |> Enum.map(&Task.async(fn -> Servy.Tracker.get_location(&1) end))
      |> Enum.map(&Task.async(Servy.Tracker, :get_location, [&1]))
      |> Enum.map(&Task.await/1)

#    %{conv |
#        status: 200,
##        resp_body: inspect(locations, limit: :infinity)
#    }

    render(conv, "sensors.eex", data: data)
  end

  def route(conv = %Conv{method: "GET", path: "/api/snapshots"}) do

    # spawn 10,000 process
    Enum.each(1..10_000, fn num ->
      Fetcher.async(fn -> VideoCam.get_snapshot("cam-#{num}") end)
    end)

    # receive message from the 10,000 process
    snapshots = Enum.map(1..10_000, fn _ ->
      Fetcher.get_result()
    end)

#    %{conv | status: 200, resp_body: inspect(snapshots, limit: :infinity)}

    render(conv, "snapshots.eex", snapshots: snapshots)
  end

  def route(conv = %Conv{method: "POST", path: "/api/bears"}) do
    Servy.Api.BearController.create(conv, conv.params)
  end

  def route(%Conv{ method: "GET", path: "/kaboom" } = _conv) do
    raise "Kaboom!"
  end

  def route(%Conv{ method: "GET", path: "/hibernate/" } = conv) do
    %{ conv | status: 200, resp_body: "Awake!" }
  end

  def route(%Conv{ method: "GET", path: "/hibernate/" <> time } = conv) do
    time |> String.to_integer |> :timer.sleep
    %{ conv | status: 200, resp_body: "Awake!" }
  end

  def route(conv = %Conv{method: "GET", path: "/wildthings"}) do
    %{conv | status: 200, resp_body: "Bears, Lions, Tigers"}
  end

  def route(conv = %Conv{method: "GET", path: "/bears"}) do
    BearController.index(conv)
  end

  def route(conv = %Conv{method: "GET", path: "/bears/"}) do
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

  def route(conv = %Conv{method: "GET", path: "/faq-bigfoot"}) do
    conv = FileHandler.file_read(@faq_bigfoot_file_path, conv)
    resp_body = Earmark.as_html!(conv.resp_body)
    %{conv | resp_body: resp_body}
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
#    """
#    HTTP/1.1 #{Conv.full_status(conv)}\r
#    Content-Type: #{conv.resp_content_type}\r
#    Content-Length: #{byte_size(conv.resp_body)}\r
#    \r
#    #{conv.resp_body}
#    """

#    IO.inspect(Servy.Conv.format_response_headers(conv))

#    """
#    HTTP/1.1 #{Conv.full_status(conv)}\r
#    Content-Type: #{conv.resp_headers["Content-Type"]}\r
#    Content-Length: #{conv.resp_headers["Content-Length"]}\r
#    \r
#    #{conv.resp_body}
#    """

    """
    HTTP/1.1 #{Conv.full_status(conv)}\r
    #{Servy.Conv.format_response_headers(conv)}
    \r
    #{conv.resp_body}
    """
  end
end

