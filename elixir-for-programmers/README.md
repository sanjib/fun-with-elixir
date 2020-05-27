# Elixir for Programmers

Personal study notes and code for the course by Dave Thomas [Elixir for Programmers](https://codestool.coding-gnome.com/courses/elixir-for-programmers)

## Stack

- BEAM: the virtual machine (for example the JVM)
- OTP: collection of middleware, libraries and tools
- Erlang: the language (Elixir is transformed into Erlang to run on BEAM)
- Hex: package manager
- Mix: build tool
- IEx: interactive tool (REPL)
- Elixir: the language

## Links

- [Installing Elixir](https://elixir-lang.org/install.html)
- [Package manager Hex](https://hex.pm/), install `mix local.hex`
- [mix deps](https://hexdocs.pm/mix/Mix.Tasks.Deps.html)

## Quotes

- Our main tools are functional composition and pattern matching.
- Composition means chaining together functions so that the output of one becomes the input of the next.
- Pattern matching lets you write different versions of the same function. This is similar to the idea of overloaded methods in some OO languages.
- When you're just starting out with Elixir, try to make yourself use pipelines all the time. A good way to remind yourself is to try not to use local variables. You won't always succeed—sometimes you just need to use them. But thinking about eliminating them will help you think in terms of transformations and pipelines.
- If you can envisage the code you’re about to write being a component in something else, make it into a separate application.

## Notes

- Do we have elixir?

```console
> elixir -v
Erlang/OTP 21 [erts-10.3] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1]

Elixir 1.10.0 (compiled with Erlang/OTP 21)
```

- Install Hex `mix local.hex`
- Run IEx `iex`, on windows use `iex --werl`

### IEx

```console
> h IO.puts             # help for IO.puts
> h String.trim         # help for String.trim
> v 1                   # value for step 1
> (v 1) / 9             # divide value for step 1 by 9
> #iex:break            # break out of an entry
> r [module-name]       # recompile module, must have been compiled at least once
> c "lib/[src-file]"    # compile source file, use for new files
```

- run iex from inside mix project directory `iex -S mix`

### mix

```console
mix new [project-name]  # create new project
mix                     # compile
mix run                 # run
mix run -e [mod].[fun]  # run mod.fun
mix help                # help
mix help run            # help for mix run
iex -S mix              # starts iex & runs default task
mix deps.get            # fetch deps
mix hex.search <package> # search for packages in hex.pm
mix test                # run tests
```

### Elixir Types

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

### Pattern matching

> The secret is that = is not really an assignment operator. Instead, it is a little game that we let Elixir play with our code.
> The rules of this game are simple:
>
> - Elixir has to make the left and right hand sides of the equals sign the same.
> - the only tool Elixir has available is the ability to bind a variable to a value.
> - this variable binding can only happen on the left hand side (LHS) of the equals sign.
>
> functions can be overloaded based on the patterns their parameters match.

```console
iex> a = 1
1
iex> 1 = a
1
iex> 2 = a
** (MatchError) no match of right hand side value: 1
iex> {a, b} = {:cat, :dog}
{:cat, :dog}
iex> {:cat, :dog} = {a, b}
{:cat, :dog}
iex> {:cat, :dog} = {b, a}
** (MatchError) no match of right hand side value: {:dog, :cat}
iex> {a, a} = {:cat, :dog}
** (MatchError) no match of right hand side value: {:cat, :dog}
```

```text
[a, _, _]   # match 3 element list, bind 1st element to a
[a, _, a]   # match 3 element list, 1st & 3rd element same, bound to a
[h | _]     # extract list head, discard tail
```

```console
iex> {a, b} = {42, 53}
{42, 53}
iex> {a, b} = {0, 53}
{0, 53}
iex> a = 42
42
iex> {^a, b} = {0, 53}  # a is pinned to existing value 42
** (MatchError) no match of right hand side value: {0, 53}
```

List pattern matching

```console
iex> list = [1, 2, 3]
[1, 2, 3]
iex> [a | b] = list
[1, 2, 3]
iex> a
1
iex> b
[2, 3]
iex> [a, b | c] = list
[1, 2, 3]
iex> a
1
iex> b
2
iex> c
[3]
iex> [a, b, c | d] = list
[1, 2, 3]
iex> a
1
iex> b
2
iex> c
3
iex> d
[]
iex> [a, b, c, e | e] = list
** (MatchError) no match of right hand side value: [1, 2, 3]
```

Simple functions to get list length, sum, double, square, map:

```elixir
defmodule Lists do
  def len([]), do: 0
  def len([_ | t]), do: 1 + len(t)

  def sum([]), do: 0
  def sum([h | t]), do: h + sum(t)

  def double([]), do: []
  def(double([h | t]), do: [h * 2 | double(t)])

  def square([]), do: []
  def(square([h | t]), do: [h * h | square(t)])

  def map([], _), do: []
  def map([h | t], f), do: [f.(h) | map(t, f)]
end
```

```console
iex> Lists.len([1, 2, 3])
3
iex> Lists.sum([1, 2, 3])
6
iex> Lists.double([1, 2, 3])
[2, 4, 6]
iex> Lists.square([1, 2, 3])
[1, 4, 9]
iex> Lists.map([1, 2, 3], fn x -> x*x*x end)
[1, 8, 27]
iex> Lists.map([1, 2, 3], &(&1 * &1 * &1))
[1, 8, 27]
```

> A list containing 1, 2, and 3 looks like this:
> `[ 1 | [ 2 | [ 3 | [] ] ] ]`
>
> This is valid Elixir syntax, but it's a pain in the butt to work with. We've already seen the shortcut syntax: `[ 1, 2, 3 ]`. Internally, Elixir converts this into the form using nested heads and tails.
>
> You can also combine notations: `[ 1, 2, 3 | [ 4, 5 ] ]` is the same as `[ 1, 2, 3, 4, 5 ]`.

Write a function even_length? that uses pattern matching only to return false if the list you pass it has an odd number of elements, true otherwise.

```elixir
defmodule Lists do
  def even_length?([_a]), do: false
  def even_length?([_a, _b]), do: true
  def even_length?([_a, _b | t]), do: even_length?(t)
end
```

```console
iex> Lists.even_length?([1])
false
iex> Lists.even_length?([1, 2])
true
iex> Lists.even_length?([1, 2, 3])
false
iex> Lists.even_length?([1, 2, 3, 4])
true
```

A few Enum functions

```console
iex> Enum.sum [1, 2, 3]
6
iex> Enum.map [1, 2, 3], fn x -> x*2 end
[2, 4, 6]
iex> Enum.map [1, 2, 3], &(&1*2)
[2, 4, 6]
```

### mix deps

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

### Testing

> you can call test source files anything you want, as long as the name ends \_test.exs
