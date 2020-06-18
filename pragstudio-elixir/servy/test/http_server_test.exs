defmodule HttpServerTest do
  use ExUnit.Case, async: true

  spawn(Servy.HttpServer, :start, [4000])

  test "GET /bears" do
    response = Servy.HttpClient.get_bears()

    expected_response = """
    HTTP/1.1 200 OK\r
    Content-Type: text/html\r
    Content-Length: 444\r
    \r
    <h1>All the Bears</h1>

    <ul>
      <li>Brutus - Grizzly</li>
      <li>Iceman - Polar</li>
      <li>Kenai - Grizzly</li>
      <li>Paddington - Brown</li>
      <li>Roscoe - Panda</li>
      <li>Rosie - Black</li>
      <li>Scarface - Grizzly</li>
      <li>Smokey - Black</li>
      <li>Snow - Polar</li>
      <li>Teddy - Brown</li>
    </ul>
    """

    assert remove_whitespace(response) == remove_whitespace(expected_response)
  end

  test "GET /wildthings" do
    request = """
    GET /wildthings HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """

    response = Servy.HttpClient.send_request(request)

    expected_response = """
    HTTP/1.1 200 OK\r
    Content-Type: text/html\r
    Content-Length: 20\r
    \r
    Bears, Lions, Tigers
    """

    assert remove_whitespace(response) == remove_whitespace(expected_response)
  end

  test "GET /wildthings using HTTPoison" do

#    {:ok, %HTTPoison.Response{status_code: 200, body: body}} = HTTPoison.get("http://localhost:4000/wildthings")
    {:ok, response} = HTTPoison.get("http://localhost:4000/wildthings")

    assert response.status_code == 200
    assert response.body == "Bears, Lions, Tigers"
  end

  defp remove_whitespace(text) do
    String.replace(text, ~r{\s}, "")
  end

  test "GET 5 requests using send/receive & HTTPoison" do
    parent = self()
    url = "http://localhost:4000/wildthings"

    Enum.each(1..5, fn _ ->
      spawn(fn -> send(parent, HTTPoison.get(url)) end)
    end)

    Enum.each(1..5, fn _ ->
      receive do
        {:ok, response} ->
          assert response.status_code == 200
          assert response.body == "Bears, Lions, Tigers"
      end
    end)
  end

  test "GET 5 requests using Task & HTTPoison" do
    url = "http://localhost:4000/wildthings"

    1..5
    |> Enum.map(fn _ -> Task.async(fn -> HTTPoison.get(url) end) end)
    |> Enum.map(fn pid ->
      {:ok, response} = Task.await(pid)
      assert response.status_code == 200
      assert response.body == "Bears, Lions, Tigers"
    end)
  end

  test "status_code 200 for 5 different URLs /bears/<id>" do
    url = "http://localhost:4000/bears/"

    1..5
    |> Enum.map(fn num ->
      Task.async(fn -> HTTPoison.get(url <> Integer.to_string(num)) end)
    end)
    |> Enum.map(fn pid ->
      {:ok, response} = Task.await(pid)
      assert response.status_code == 200
    end)
  end

  test "status_code 200 for 5 different URLs" do
    urls = [
      "http://localhost:4000/bears/",
      "http://localhost:4000/bears/1",
      "http://localhost:4000/wildthings",
      "http://localhost:4000/wildlife",
      "http://localhost:4000/api/bears",
    ]

    urls
    |> Enum.map(fn url ->
      Task.async(fn -> HTTPoison.get(url) end)
    end)
    |> Enum.map(fn pid ->
      {:ok, response} = Task.await(pid)
      assert response.status_code == 200
    end)
  end

end