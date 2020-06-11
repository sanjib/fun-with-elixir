# Comprehensions

```console
iex> prefs = [{"Betty", :dog}, {"Bob", :dog}, {"Becky", :cat}]
[{"Betty", :dog}, {"Bob", :dog}, {"Becky", :cat}]
```
```console
iex> for {name, :dog} <- prefs, do: name
["Betty", "Bob"]
iex> for {name, :cat} <- prefs, do: name
["Becky"]
```
```console
iex> for {name, animal} <- prefs, animal==:dog, do: name
["Betty", "Bob"]
iex> for {name, animal} <- prefs, animal==:cat, do: name
["Becky"]
```
```console
iex> dog_lover? = &(&1 == :dog)
#Function<6.128620087/1 in :erl_eval.expr/5>
iex> cat_lover? = &(&1 == :cat)
#Function<6.128620087/1 in :erl_eval.expr/5>
iex> for {name, animal} <- prefs, dog_lover?, do: name  
["Betty", "Bob", "Becky"]
iex> for {name, animal} <- prefs, cat_lover?, do: name
["Betty", "Bob", "Becky"]
```
```console
iex> style = %{"width" => 10, "height" => 20, "border" => "2px"}
%{"border" => "2px", "height" => 20, "width" => 10}
```
```console
iex> Map.new(style, fn {key, val} -> {String.to_atom(key), val} end)
%{border: "2px", height: 20, width: 10}
iex> for {key, val} <- style, into: %{}, do: {String.to_atom(key), val}
%{border: "2px", height: 20, width: 10}
```
