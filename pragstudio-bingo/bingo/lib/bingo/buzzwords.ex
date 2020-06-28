defmodule Bingo.Buzzwords do
  @moduledoc false


  def read_buzzwords(filename_in_data_dir \\ "buzzwords.csv") do
    "../../data/#{filename_in_data_dir}"
    |> Path.expand(__DIR__)
    |> File.read!
    |> String.split("\n")
    |> Enum.map(&String.trim/1)

  end

end
