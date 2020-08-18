defmodule Rumbl.Accounts do
  @moduledoc """
  The Accounts context.
  """

  alias Rumbl.Repo
  alias Rumbl.Accounts.User

  #-- authenticate

  def authenticate_with_user_pass(username, given_password) do
    user = get_user_by(username: username)
    cond do
      user && Pbkdf2.verify_pass(given_password, user.password_hash) ->
	{:ok, user}
      user ->
	{:error, :unauthorized}
      true ->
	Pbkdf2.no_user_verify()
	{:error, :not_found}
    end
  end
  
  #-- create user
  
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  #-- create reg user

  def create_reg_user(attrs \\ %{}) do
    %User{}
    |> User.reg_changeset(attrs)
    |> Repo.insert
  end

  def change_reg_user(%User{} = user) do
    User.reg_changeset(user, %{})
  end

  #-- get
  
  def get_user(id) do
    Repo.get(User, id)
  end

  def get_user!(id) do
    Repo.get!(User, id)
  end

  def get_user_by(params) do
    Repo.get_by(User, params)
  end

  def list_users do
    Repo.all(User)
  end

end
