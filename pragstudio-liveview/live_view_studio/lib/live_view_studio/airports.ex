defmodule LiveViewStudio.Airports do

  def suggest(""), do: []
  def suggest(prefix) do
    prefix = String.upcase(prefix)
    list()
    |> Enum.filter(&String.starts_with?(&1, prefix))
  end

  def list do
    [
      "BKK",
      "CPH",
      "DAB",
      "DEN",
      "DFW",
      "LHR",
      "ORD",
    ]
  end
end

