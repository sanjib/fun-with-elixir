defmodule Servy.Tracker do
  def get_location(wildthing) do

    sleep_for = Enum.random(1..1000)
    :timer.sleep(sleep_for)

    data = %{
      "roscoe"  => %{lat: "44.4280 N", lng: "110.5885 W", name: "roscoe", sleep_for: sleep_for},
      "smokey"  => %{lat: "48.7596 N", lng: "113.7870 W", name: "smokey", sleep_for: sleep_for},
      "brutus"  => %{lat: "43.7904 N", lng: "110.6818 W", name: "brutus", sleep_for: sleep_for},
      "bigfoot" => %{lat: "29.0469 N", lng: "98.8667 W",  name: "bigfoot", sleep_for: sleep_for},
    }
    Map.get(data, wildthing)
  end
end
