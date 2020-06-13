# Servy

Some notable code, note the Poison.decode function param "as:".
Converts a regular map inside a list to a struct %Bear.

```elixir
Path.absname("../../db", __DIR__)
|> Path.join("bears.json")
|> File.read!
|> Poison.decode!(as: %{"bears" => [%Bear{}]})
|> Map.get("bears")
```