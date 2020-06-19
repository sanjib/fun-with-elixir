# HTTPoison

post and receive request

```console
iex> url = "http://httparrot.herokuapp.com/post"
"http://httparrot.herokuapp.com/post"
iex> body = ~s/{"name": "larry", "amount": 10}/
"{\"name\": \"larry\", \"amount\": 10}"
iex> headers = [{"Content-Type", "application/json"}]
[{"Content-Type", "application/json"}]
iex> {:ok, response} = HTTPoison.post url, body      
{:ok,
 %HTTPoison.Response{
   body: "{\"args\":{},\"headers\":{\"connect-time\":\"0\",\"connection\":\"close\",\"content-length\":\"31\",\"content-type\":\"application/octet-stream\",\"host\":\"httparrot.herokuapp.com\",\"total-route-time\":\"0\",\"user-agent\":\"hackney/1.16.0\",\"via\":\"1.1 vegur\",\"x-forwarded-for\":\"202.186.130.68\",\"x-forwarded-port\":\"80\",\"x-forwarded-proto\":\"http\",\"x-request-id\":\"28608ba4-0362-49dd-b5d9-965ff978548e\",\"x-request-start\":\"1592540621549\"},\"url\":\"http://httparrot.herokuapp.com/post\",\"origin\":\"10.79.182.75\",\"form\":{},\"data\":\"{\\\"name\\\": \\\"larry\\\", \\\"amount\\\": 10}\",\"json\":{\"amount\":10,\"name\":\"larry\"}}",
   headers: [
     {"Connection", "keep-alive"},
     {"Content-Length", "566"},
     {"Content-Type", "application/json"},
     {"Date", "Fri, 19 Jun 2020 04:23:41 GMT"},
     {"Server", "Cowboy"},
     {"Via", "1.1 vegur"}
   ],
   request: %HTTPoison.Request{
     body: "{\"name\": \"larry\", \"amount\": 10}",
     headers: [],
     method: :post,
     options: [],
     params: %{},
     url: "http://httparrot.herokuapp.com/post"
   },
   request_url: "http://httparrot.herokuapp.com/post",
   status_code: 200
 }}
iex> Poison.Parser.parse!(response.body, %{})
%{
  "args" => %{},
  "data" => "{\"name\": \"larry\", \"amount\": 10}",
  "form" => %{},
  "headers" => %{
    "connect-time" => "0",
    "connection" => "close",
    "content-length" => "31",
    "content-type" => "application/octet-stream",
    "host" => "httparrot.herokuapp.com",
    "total-route-time" => "0",
    "user-agent" => "hackney/1.16.0",
    "via" => "1.1 vegur",
    "x-forwarded-for" => "202.186.130.68",
    "x-forwarded-port" => "80",
    "x-forwarded-proto" => "http",
    "x-request-id" => "28608ba4-0362-49dd-b5d9-965ff978548e",
    "x-request-start" => "1592540621549"
  },
  "json" => %{"amount" => 10, "name" => "larry"},
  "origin" => "10.79.182.75",
  "url" => "http://httparrot.herokuapp.com/post"
}
```

