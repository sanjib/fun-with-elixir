# Scratch

```console
iex(3)> defmodule Namer do
...(3)> @name "nicole"
...(3)> def her_name, do: @name
...(3)> @name "mike"
...(3)> def his_name, do: @name
...(3)> end
{:module, Namer,
 <<70, 79, 82, 49, 0, 0, 5, 92, 66, 69, 65, 77, 65, 116, 85, 56, 0, 0, 0, 137,
   0, 0, 0, 14, 12, 69, 108, 105, 120, 105, 114, 46, 78, 97, 109, 101, 114, 8,
   95, 95, 105, 110, 102, 111, 95, 95, 7, ...>>, {:his_name, 0}}
iex(4)> Namer.his_name
"mike"
iex(5)> Namer.her_name
"nicole"

```