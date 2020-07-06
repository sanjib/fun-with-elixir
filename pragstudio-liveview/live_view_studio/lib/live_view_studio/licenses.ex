defmodule LiveViewStudio.Licenses do

  def calculate(seats) do
    if seats <= 5 do
      seats * 200.0
    else
      1000.0 + (seats - 5) * 150.0
    end
  end

end