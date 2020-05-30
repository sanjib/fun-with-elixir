# Exercises

#### 1. Here’s a geeky shopping list. The first entry in each tuple is some kind of size or quantity, and the second is the item description.

```elixir
shopping = [
  { "1 dozen", "eggs" },
  { "1 ripe", "melon" },
  { "4", "apples" },
  { "2 boxes", "tea" },
]
```

Use EEx to format this into a nice (text) table:

```console
   quantity | item
   --------------------
    1 dozen | eggs
     1 ripe | melon
          4 | apples
    2 boxes | tea
```

Solution:

```elixir
template = """
quantity | item
--------------------
<%= for {quantity, item} <- list do %>
<%= String.pad_leading(quantity, 8) %> | <%= item %>
<% end %>
"""

shopping_list = [
  {"1 dozen", "eggs"},
  {"1 ripe", "melon"},
  {"4", "apples"},
  {"2 boxes", "tea"}
]

EEx.eval_string(template, [list: shopping_list], trim: true)
|> IO.puts()
```

#### 2. Modify the plural_of helper so that it returns the count as well as the name of the thing, so

```console
plural_of("egg", 1)     ⇒ 1 egg
plural_of("egg", 2)     ⇒ 2 eggs
```

Further extend the plural_of helper so that if the count is negative, the resulting string will be displayed in red. There’s no need to go messing with stylesheets; just use <span style="color: red">...

Solution:

```elixir
def plural_of(word, 1), do: "1 #{word}" |> format_result(false)
def plural_of(word, count), do: "#{count} #{word}s" |> format_result(count < 0)

def format_result(str, neg_count = true) do
  {:safe, ~s/<span style="color: red;">#{str}<\/span>/}
end

def format_result(str, _neg_count_is_false) do
  {:safe, ~s/<span style="color: black;">#{str}<\/span>/}
end
```
