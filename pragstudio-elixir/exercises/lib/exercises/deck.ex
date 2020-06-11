defmodule Exercises.Deck do

  def create() do
    ranks = [ "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A" ]
    suits = [ "♣", "♦", "♥", "♠" ]

    for suit <- suits, rank <- ranks, do: {rank, suit}
  end

  def deal([]), do: {[], []}

  def deal(deck) do
    Enum.reduce(1..13, {[], deck}, fn _, {hand, deck} ->
      random_card = Enum.random(deck)
      deck = List.delete(deck, random_card)
      hand = [random_card | hand]
      {hand, deck}
    end)
  end

  def deal(deck, number_of_hands) do
    Enum.reduce(1..number_of_hands, {[], deck}, fn _, {hands, deck} ->
      {hand, deck} = deal(deck)
      hands = [hand | hands]
      {hands, deck}
    end)
  end

  def easy_deal(deck) do
    deck
    |> Enum.shuffle
    |> Enum.take(13)
  end

  def easy_deal_all_cards(deck) do
    deck
    |> Enum.shuffle
    |> Enum.chunk_every(13)
  end

end
