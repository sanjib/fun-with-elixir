defmodule Dictionary do
  alias Dictionary.WordList

  defdelegate start(), to: WordList, as: :start_link
  defdelegate random_word(word_list), to: WordList
end
