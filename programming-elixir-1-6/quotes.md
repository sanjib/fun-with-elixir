## Chapter 1 

> - Object orientation is not the only way to design code.
> - Functional programming need not be complex or mathematical.
> - The bases of programming are not assignments, if statements, and loops.
> - Concurrency does not need locks, semaphores, monitors, and the like.
> - Processes are not necessarily expensive resources.
> - Metaprogramming is not just something tacked onto a language.
> - Even if it is work, programming should be fun.

## Chapter 2

> - In Elixir, the equals sign is not an assignment. Instead it’s like an assertion.
> - Joe Armstrong, Erlang’s creator, compares the equals sign in Erlang to that
used in algebra. When you write the equation x = a + 1, you are not assigning
the value of a + 1 to x. Instead you’re simply asserting that the expressions
x and a + 1 have the same value.

## Chapter 3
> - But the cool thing about Elixir is that you write your code using lots and lots of processes, and each process has its own heap.

## Chapter 15

> - We ran a million processes (sequentially) in just over 5 seconds.
> - This kind of performance is stunning, and it changes the way we design code. We can now create hundreds of little helper processes.
> - And each process can contain its own state—in a way, processes in Elixir are like objects in an object-oriented system (but they’re more self-contained).