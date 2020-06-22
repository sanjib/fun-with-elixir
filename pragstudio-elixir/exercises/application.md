# Application

- Application.started_applications
- Application.stop
- Application.start

Example, lib/servy.ex

```elixir
defmodule Servy do
  use Application

  def start(_type, _args) do
    IO.puts "Starting the Application..."
    Servy.Supervisor.start_link()
  end

end
def application do
  [
    extra_applications: [:logger],
    mod: {Servy, []},
    env: [port: 4000],
  ]
end
```

Example, lib/servy/application.ex

```elixir
defmodule Servy.Application do
  use Application

  def start(_type, _args) do
    IO.puts "Starting the application..."
    Servy.Supervisor.start_link()
  end
end
def application do
  [
    extra_applications: [:logger],
    mod: {Servy.Application, []},
    env: [port: 4000],
  ]
end
```


