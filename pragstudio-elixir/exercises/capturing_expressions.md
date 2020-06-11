# Capturing Expressions

```console
> Enum.map(["a", "b", "c"], &String.upcase(&1))
["A", "B", "C"]

> Enum.map([1, 2, 3], &(&1 * 3))
[3, 6, 9]

> triple = &(&1 * 3)
#Function<6.118419387/1 in :erl_eval.expr/5>
> Enum.map([1, 2, 3], triple)
[3, 6, 9]
```