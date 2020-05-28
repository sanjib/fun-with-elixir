# Elixir Types

- integers & floats

```console
iex> 123_456_789    # writing long numbers
123456789
iex> 0x41           # 0x hex
65
iex> 0o101          # 0o octal
65
iex> 0b100_0001     # 0b binary
65
iex> ?A             # codepoint
65
iex> ?≠             # codepoint
8800
```

- useful functions

```console
iex> 4/2        # int division always returns float
2.0
iex> 5/2        # int division always returns float
2.5
iex> div(5, 2)  # returns truncated int
2
iex> trunc(5/2) # returns truncated int
2
iex> round(5/2) # returns rounded int
3
iex> String.to_integer("65") # converts string to int
65

```

- atoms

```console
iex> :cat_dog       # example atom
:cat_dog
iex> :"cat-dog"     # example atom with - wrapped in double quotes
:"cat-dog"
iex> a = 99
99
iex> str = "mario scored #{a + 1}" # also used for var interpolation
"mario scored 100"
iex> Foo            # create atom with name starting in upper case letter
Foo
iex> is_atom(Foo)
true
iex> is_atom(Dictionary) # module names are atoms
true
iex> Dictionary == :"Elixir.Dictionary" # automatically prefixed with Elixir. to avoid name clash
true
```

- booleans: nil and false are falsy, all others truthy

```console
iex> 100 >>> 1  # bitwise arithmetic shift
50
```

- ranges: are inclusive of the number specified

```console
iex> b = 8..3
8..3
iex> for i <- b, do: i
[8, 7, 6, 5, 4, 3]
iex> a = 5..10
5..10
iex> for i <- a, do: i
[5, 6, 7, 8, 9, 10]
iex> 4 in a   # in operator checks if int falls between two bounds
false
iex> 4 in b   # in operator checks if int falls between two bounds
true
```

- sigils

  - notation for creating values from strings
  - all sigils start with ~
  - followed by single character that determines sigil type
    - ~c list of character codes
    - ~r regular expression
    - ~s string
    - ~w list of words
  - then delimiters, examples: //, "", '', ||, <>, [], (), {} """
  - then the actual string
  - finally optional flags

```console
iex> ~c/cat/
'cat'
iex> ~c/cat\0/
[99, 97, 116, 0]
iex> 'cat\0'
[99, 97, 116, 0]
iex> ~r/cat/i
~r/cat/i
iex> ~s/dog/
"dog"
iex> ~w/hello world/
["hello", "world"]
```

- string: is a sequence of Unicode codepoints

  - strings are immutable
  - "hello" is equivalent to ~s/hello/
  - <> operator concatenates

The function Time.utc_now returns the UTC time. Interpolate it into a string using both a double-quote literal and a sigil.

```console
iex> "The time now is: #{Time.utc_now}"
"The time now is: 16:03:59.839000"
iex> ~s/The time now is: #{Time.utc_now}/
"The time now is: 16:04:15.677000"
```

You have to output the instructions on how to interpolate expressions into strings. Use IO.puts to output:

`For example, 1 + 2 = #{ 1 + 2 }`

```console
iex> IO.puts "1 + 2 = \#{ 1 + 2 }"
1 + 2 = #{ 1 + 2 }
iex> IO.puts ~S/1 + 2 = #{ 1 + 2 }/
1 + 2 = #{ 1 + 2 }
:ok
```

Use a sigil to transform "now is the time" into the list

`[ "now", "is", "the", "time" ]`

```console
iex> ~w/now is the time/
["now", "is", "the", "time"]
```

- regular expressions

```console
iex> str = "once upon a time"
"once upon a time"
iex> str =~ ~r/u..n/
true
iex> str =~ ~r/u..m/
false
```

Write an expression that returns true if a string contains an a, followed by any character, then a c (so abc, and arc will return true, and ace will not).

```console
iex> re = ~r/a.c/
~r/a.c/
iex(77)> "abc" =~ re
true
iex(78)> "arc" =~ re
true
iex(79)> "ace" =~ re
false
```

Write an expression that takes a string and replaces every occurrence of cat with dog.

```console
iex> Regex.replace(~r/cat/i, "A Cat is a cat is a cat", "dog")
"A dog is a dog is a dog"
```

Do the same, but only replace the first occurrence.

```console
iex> Regex.replace(~r/cat/i, "A Cat is a cat is a cat", "dog", global: false)
"A dog is a cat is a cat"
```

- tuples: fixed length collection of values

```console
iex> foo = {:ok, "wilma"}
{:ok, "wilma"}
iex> elem(foo, 0)
:ok
iex> elem(foo, 1)
"wilma"
```

- lists

  - are not arrays
  - very easy to add/remove elements at the head of the list

```console
iex> c = [:c | []]
[:c]
iex> bc = [:b | c]
[:b, :c]
iex> abc = [:a | bc]
[:a, :b, :c]
```

- maps
  - unordered collection of key/value pairs
  - key/value can be any Elixir type and can be mixed
  - use the functions in the Map and Enum modules

```console
iex> lang = %{
...> :en => "English",
...> :da => "Danish",
...> :es => "Spanish",
...> :de => "German",
...> :bn => "Bengali",
...> }
%{bn: "Bengali", da: "Danish", de: "German", en: "English", es: "Spanish"}
iex> lang[:bn]
"Bengali"
iex> lang.bn
"Bengali"
iex> lang = %{
...> bn: "Bengali",
...> en: "English",
...> }
%{bn: "Bengali", en: "English"}
iex> lang.bn
"Bengali"
iex> lang.it
** (KeyError) key :it not found in: %{bn: "Bengali", en: "English"}
iex> lang[:it]
nil
```
