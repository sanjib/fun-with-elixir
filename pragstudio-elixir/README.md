# Developing with Elixir/OTP

Study notes and code from following the Pragmatic Studio course Developing with Elixir/OTP.

```console
iex(34)> "/bears/" <> id = "/bears/1"
"/bears/1"
iex(35)> id
"1"
```

```console
import Servy.Plugins, only: [rewrite_path: 1, log: 1, track: 1]
import Servy.Parser, only: [parse: 1]

import SomeModule, only: :functions
import SomeModule, only: :macros

@pages_path Path.expand("../../pages", __DIR__)
@pages_path Path.expand("pages", File.cwd!)
```

## Quotes

```console
<%= inspect(bears) %>
```

> - Calling the inspect function is fundamentally different from calling the IO.inspect function. Calling inspect returns a string representing its argument whereas calling IO.inspect inspects its argument and writes the result to a device such as the console. So in a template file, you always want to use inspect.