defmodule GallowsWeb.PageView do
  use GallowsWeb, :view

  def plural_of(word, 1), do: "1 #{word}" |> format_result(false)
  def plural_of(word, count), do: "#{count} #{word}s" |> format_result(count < 0)

  def format_result(str, neg_count = true) do
    {:safe, ~s/<span style="color: red;">#{str}<\/span>/}
  end

  def format_result(str, _neg_count_is_false) do
    {:safe, ~s/<span style="color: black;">#{str}<\/span>/}
  end
end
