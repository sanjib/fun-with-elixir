defmodule HelloWeb.HelloController do
  use HelloWeb, :controller

  def hello(conn, _params) do
    render(conn, "hello.html")
  end
end