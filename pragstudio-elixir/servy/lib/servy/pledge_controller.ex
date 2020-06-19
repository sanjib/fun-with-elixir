defmodule Servy.PledgeController do

    import Servy.View, only: [render: 3]

  def create(conv, %{"name" => name, "amount" => amount}) do
    Servy.PledgeServer.create_pledge(name, String.to_integer(amount))
    %{conv | status: 201, resp_body: "#{name} pledged amount #{amount}"}
  end

  def new(conv, params, error) do
    IO.puts ("--> error: #{inspect error}")

    render(conv, "pledges_new.eex",
      name: params["name"],
      amount: params["amount"],
      error: error
    )
  end

  def index(conv) do
    pledges = Servy.PledgeServer.recent_pledges()
    # %{conv | status: 200, resp_body: (inspect pledges)}

    render(conv, "pledges_recent.eex", pledges: pledges)
  end
end
