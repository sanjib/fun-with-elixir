defmodule UserApi do

  @url "https://jsonplaceholder.typicode.com/users/"

  def query(id) do
    @url <> id
    |> HTTPoison.get
    |> parse_result
  end

  def parse_result({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    city = body
    |> Poison.Parser.parse!
    |> get_in(["address", "city"])
    {:ok, city}
  end

  def parse_result({:ok, %HTTPoison.Response{status_code: _status, body: body}}) do
    message = body
    |> Poison.Parser.parse!
    |> get_in(["message"])
    {:error, message}
  end

  def parse_result({:error, %HTTPoison.Error{reason: reason}}) do
    {:error, reason}
  end
end
