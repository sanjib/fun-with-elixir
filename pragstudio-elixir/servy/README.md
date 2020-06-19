# Servy

## Run

In IEx:

```console
iex> Servy.PledgeServer.start
Starting the pledge server...
#PID<0.224.0>

iex> Servy.FourOhFourCounter.start
Starting Four Oh Four Counter...
#PID<0.243.0>

iex> spawn Servy.HttpServer, :start, [4000]
#PID<0.246.0>     
Listening for connection requests on port 4000...
Waiting to accept a client connection...
```

## Misc

Posting to Servy.PledgeServer using HTTPoison:

```console
iex> url = "http://localhost:4000/pledges"
"http://localhost:4000/pledges"

iex> headers = [{"Content-Type", "application/x-www-form-urlencoded"}]
[{"Content-Type", "application/x-www-form-urlencoded"}]

iex> body = "name=larry&amount=100"
"name=larry&amount=100"

iex> HTTPoison.post url, body, headers

```


Some notable code, note the Poison.decode function param "as:".
Converts a regular map inside a list to a struct %Bear.

```elixir
Path.absname("../../db", __DIR__)
|> Path.join("bears.json")
|> File.read!
|> Poison.decode!(as: %{"bears" => [%Bear{}]})
|> Map.get("bears")
```