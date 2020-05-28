# Dependencies

## mix deps

```elixir
def deps() do
  [
    {:dictionary, path: "../dictionary" },  # local
    {:pusher, github: "pragdave/pusher" },  # github
    {:earmark, "~> 1.0.0" }, # hex.pm
    {:x, "~> 1.2.3"} # matches 1.2.3, 1.2.4, 1.2.11, but not 1.3.0
  ]
end
```
