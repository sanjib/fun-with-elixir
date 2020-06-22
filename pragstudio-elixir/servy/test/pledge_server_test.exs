defmodule PledgeServerTest do
  use ExUnit.Case, async: true

  Servy.PledgeServerHandRolled.start()

  test "caches only the 3 most recent pledges and totals their amounts" do
    Servy.PledgeServerHandRolled.create_pledge("larry", 10)
    Servy.PledgeServerHandRolled.create_pledge("moe", 20)
    Servy.PledgeServerHandRolled.create_pledge("curly", 30)
    Servy.PledgeServerHandRolled.create_pledge("daisy", 40)
    Servy.PledgeServerHandRolled.create_pledge("grace", 50)

    assert length(Servy.PledgeServerHandRolled.recent_pledges) == 3
    assert Servy.PledgeServerHandRolled.total_pledged == 120

  end
end