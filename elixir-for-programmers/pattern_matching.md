# Pattern matching

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
