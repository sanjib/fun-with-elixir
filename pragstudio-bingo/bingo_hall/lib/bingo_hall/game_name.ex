defmodule BingoHall.GameName do
  def get do
    [
      Enum.random(adjectives),
      Enum.random(nouns),
      :rand.uniform(9999),
    ]
    |> Enum.join("-")
  end

  defp adjectives do
    ["brave", "bright", "calm", "creative", "funny", "gentle", "good", "honest", "kind", "loving",
      "modest", "neat", "nice", "polite", "shy", "sincere", "tidy", "tough", "witty"]
  end

  defp nouns do
    ["apple", "banana", "book", "cat", "day", "dog", "egg", "elephant", "fish", "gal", "gorilla",
      "home", "honey", "ice", "jasmine", "lad", "money", "otter", "parrot", "unicorn", "zebra"]
  end
end