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