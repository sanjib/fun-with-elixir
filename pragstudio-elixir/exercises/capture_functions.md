# Capture Functions

- Write an anonymous function that adds two numbers and call it
```console
iex> add = fn a, b -> a + b end
#Function<12.128620087/2 in :erl_eval.expr/5>
iex> add.(7, 3)
10
```
- Adds two numbers: a shorthand version that uses the & capture operator
```console
iex> add = &(&1 + &2)
&:erlang.+/2
iex> add.(7, 3)      
10
```

- Look up the documentation for the String.duplicate function. Can you think of two ways to capture it? Try both ways and call the result with your favorite repetitive phrases.

```console
iex> dup1 = &String.duplicate(&1, &2)
&:binary.copy/2
iex> dup1.("*", 10)
"**********"
iex> dup2 = &String.duplicate/2
&:binary.copy/2
iex> dup2.("*", 10)            
"**********"
```
