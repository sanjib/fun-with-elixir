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
- Never connect nodes over unencrypted networks, anyone can listen.
- By keeping out various apps separate (dictionary, hangman, text client, and gallows), and because our dependencies are strictly one-way, we are able to remove the entire gallows directory tree after we messed it up without impacting anything else.
- Getting familiar with where things live in Phoenix is one if the keys to productivity, and that familiarity comes from practice.
- I like Elixir and Phoenix because they let me write in this style. I can write clear, maintainable, and performant code, where every function represents a clear transformation of state.
- Use partial templates to break large templates into more manageable chunks. In particular, I like to arrange things so that all the code in a template is at roughly the same level, and that it doesn’t get deeper that about three levels of nesting.

## Notes

- [Elixir](./elixir.md)
- [Hex](./hex.md)
- [IEx](./iex.md)
- [Mix](./mix.md)
- [Elixir Types](./elixir_types.md)
- [Pattern Matching](./pattern-matching.md)
- [Dependencies](./dependencies.md)
- [Testing](./testing.md)
- [Processes & State](./processes_and_state.md)
