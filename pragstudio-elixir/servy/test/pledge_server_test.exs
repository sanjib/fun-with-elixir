defmodule PledgeServerTest do
  use ExUnit.Case, async: true

  Servy.PledgeServer.start()

  test "caches only the 3 most recent pledges and totals their amounts" do
    Servy.PledgeServer.create_pledge("larry", 10)
    Servy.PledgeServer.create_pledge("moe", 20)
    Servy.PledgeServer.create_pledge("curly", 30)
    Servy.PledgeServer.create_pledge("daisy", 40)
    Servy.PledgeServer.create_pledge("grace", 50)

    assert length(Servy.PledgeServer.recent_pledges) == 3
    assert Servy.PledgeServer.total_pledged == 120

  end
end