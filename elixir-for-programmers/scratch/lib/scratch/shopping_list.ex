defmodule Scratch.ShoppingList do
  def format_shopping_list() do
    template = """
    quantity | item
    --------------------
    <%= for {quantity, item} <- list do %>
    <%= String.pad_leading(quantity, 8) %> | <%= item %>
    <% end %>
    """

    shopping_list = [
      {"1 dozen", "eggs"},
      {"1 ripe", "melon"},
      {"4", "apples"},
      {"2 boxes", "tea"}
    ]

    EEx.eval_string(template, [list: shopping_list], trim: true)
    |> IO.puts()
  end
end
