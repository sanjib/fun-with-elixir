# Gallows

To start your Phoenix server:

- Setup the project with `mix setup`
- Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

- Official website: https://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Forum: https://elixirforum.com/c/phoenix-forum
- Source: https://github.com/phoenixframework/phoenix

## Running

Start your Phoenix app with:

```console
$ mix phx.server
```

You can also run your app inside IEx (Interactive Elixir) as:

```console
$ iex -S mix phx.server
```

## Some files and functions

- lib/gallows/application.ex - normal application entry point
- lib/gallows_web/endpoint.ex - entry point for communications
- lib/gallows_web/router.ex - send requests to correct controller/function
- lib/gallows_web/controllers/page_controller.ex - handle specific request
- lib/templates/layout/app.html.eex - app-wide page layout
- lib/templates/page/index.html.eex - per request page layout
- lib/views/page_view.ex - support code for templates

## Templates and EEx

> EEx stands for Embedded Elixir. It allows you to embed
Elixir code inside a string in a robust way.


```console
iex> EEx.eval_string ~s/hello <%= String.upcase("mars") %>/
"hello MARS"
iex> template = "the <%= animal %> says <%= sound %>"
"the <%= animal %> says <%= sound %>"
iex> EEx.eval_string(template, animal: "sheep", sound: "bah")
"the sheep says bah"
iex> animals = ["ant", "bee", "cat"]
["ant", "bee", "cat"]
iex> template = """
...> <%= for item <- list do %>
...> the animal is <%= item %>
...> <% end %>
...> """
"<%= for item <- list do %>\nthe animal is <%= item %>\n<% end %>\n"
iex> IO.puts EEx.eval_string(template, list: animals)
the animal is ant
the animal is bee
the animal is cat
:ok
iex> EEx.eval_string "Hello, <%= @person %>", assigns: [person: "Sid"]
"Hello, Sid"
```

## Notes

- [Quotes](./quotes.md)
- [Exercises](./exercises.md)