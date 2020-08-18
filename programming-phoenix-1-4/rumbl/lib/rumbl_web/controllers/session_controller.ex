defmodule RumblWeb.SessionController do
  use RumblWeb, :controller
  
  alias Rumbl.Accounts
  alias RumblWeb.Auth
  
  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => %{"username" => username, "password" => password}}) do
    case Accounts.authenticate_with_user_pass(username, password) do
      {:ok, user} ->
	conn
	|> Auth.login(user)
	|> put_flash(:info, "Welcome back #{user.name}")
	|> redirect(to: Routes.page_path(conn, :index))
      {:error, reason} ->
	conn
	|> put_flash(:error, "There was an error logging in: #{reason}")
	|> render("new.html")
    end
  end

  def delete(conn, _params) do
    conn
    |> Auth.logout()
    |> put_flash(:info, "Thank you for visiting. You have been logged out now.")
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
