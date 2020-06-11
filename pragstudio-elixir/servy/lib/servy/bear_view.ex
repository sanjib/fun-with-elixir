defmodule Servy.BearView do

  require EEx

  @templates_path Path.expand("../../templates", __DIR__)

  @index @templates_path |> Path.join("index.eex")
  @show @templates_path |> Path.join("show.eex")

  EEx.function_from_file :def, :index, @index, [:bears]
  EEx.function_from_file :def, :show, @show, [:bear]

end
