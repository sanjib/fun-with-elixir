# Dictionary

The dictionary module.

## Notes

### mix

```console
mix run -e Dictionary.hello
iex -S mix
```

### iex

```console
> Dictionary.hello
> r Dictionary
> c "lib/dictionary.ex"
> str = "123\n456\n789n"
> String.split(str, ~r/\n/)
["123", "456", "789", ""]
```

## Code Compare

```console
> IO.puts(length(String.split("1-2-3", "-")))
3
:ok
> "1-2-3" |> String.split("-") |> length |> IO.puts
3
:ok
```

## Exercises

Bind the string "had we but world enough, and time" to a variable.
Use functions from the String module to:

- Split it into two parts: the stuff before and the stuff after the comma.

```console
> str = "had we but world enough, and time"
> String.split(str, ~r/,/)
["had we but world enough", " and time"]

```

- Split it into a list of characters, where each entry in the list is a single character string.

```console
> String.split(str, ~r//)
["", "h", "a", "d", " ", "w", "e", " ", "b", "u", "t", " ", "w", "o", "r", "l",
 "d", " ", "e", "n", "o", "u", "g", "h", ",", " ", "a", "n", "d", " ", "t", "i",
 "m", "e", ""]
> String.split(str, ~r//, trim: true)
["h", "a", "d", " ", "w", "e", " ", "b", "u", "t", " ", "w", "o", "r", "l", "d",
 " ", "e", "n", "o", "u", "g", "h", ",", " ", "a", "n", "d", " ", "t", "i", "m",
 "e"]
> String.codepoints(str)
["h", "a", "d", " ", "w", "e", " ", "b", "u", "t", " ", "w", "o", "r", "l", "d",
 " ", "e", "n", "o", "u", "g", "h", ",", " ", "a", "n", "d", " ", "t", "i", "m",
 "e"]
```

- Split it into a list of characters, where each entry in the list is the integer representation of that character.

```console
> str3 = str <> "á"
"had we but world enough, and timeá"
> String.to_charlist(str3)
[104, 97, 100, 32, 119, 101, 32, 98, 117, 116, 32, 119, 111, 114, 108, 100, 32,
 101, 110, 111, 117, 103, 104, 44, 32, 97, 110, 100, 32, 116, 105, 109, 101,
 225]
> ~c/#{str}\0/
[104, 97, 100, 32, 119, 101, 32, 98, 117, 116, 32, 119, 111, 114, 108, 100, 32,
 101, 110, 111, 117, 103, 104, 44, 32, 97, 110, 100, 32, 116, 105, 109, 101, 0]

```

ignore the last result above 225 as it represents "á"

- reverse the string (hmmm… the first two words of the result are interesting)

```console
> String.reverse(str)
"emit dna ,hguone dlrow tub ew dah"
```

- calculate the set of differences between this string and "had we but bacon enough, and treacle"; you should get

```console
[
  eq: "had we but ", del: "w", ins: "bac", eq: "o",
  del: "rld", ins: "n", eq: " enough, and t", del: "im",
  ins: "r", eq: "e", ins: "acle"
]
```

```console
> String.myers_difference(str, str2)
[
  eq: "had we but ",
  del: "w",
  ins: "bac",
  eq: "o",
  del: "rld",
  ins: "n",
  eq: " enough, and t",
  del: "im",
  ins: "r",
  eq: "e",
  ins: "acle"
]
```

## Steps to make a library into an application

```elixir
# mix.exs
def application do
  [
    mod: {Dictionary.Application, []},
    extra_applications: [:logger]
  ]
end

# application.ex
def start(_type, _args) do
  Dictionary.WordList.start_link()
end
```
