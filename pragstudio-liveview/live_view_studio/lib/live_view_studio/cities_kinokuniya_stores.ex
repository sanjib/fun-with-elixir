defmodule LiveViewStudio.CitiesKinokuniyaStores do
  def suggest(""), do: []

  def suggest(city) do
    list_cities
    |> Enum.filter(&(&1 =~ ~r/#{city}/i))
  end

  def list_cities do
    [
      "Bangkok",
      "Dubai",
      "Edgewater",
      "Jakarta",
      "Kuala Lumpur",
      "Los Angeles",
      "New York",
      "San Francisco",
      "Singapore",
      "Sydney",
    ]
  end
end