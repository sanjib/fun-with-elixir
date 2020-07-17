defmodule LiveViewStudio.KinokuniyaStores do
  @moduledoc """
  The KinokuniyaStores context.
  """

  import Ecto.Query, warn: false
  alias LiveViewStudio.Repo

  alias LiveViewStudio.KinokuniyaStores.KinokuniyaStore

  @doc """
  Returns the list of kinokuniya_stores.

  ## Examples

      iex> list_kinokuniya_stores()
      [%KinokuniyaStore{}, ...]

  """
  def list_kinokuniya_stores do
    Repo.all(KinokuniyaStore)
  end

  def list_by_country(country) do
    list_kinokuniya_stores()
    |> Enum.filter(&(&1.country == country))
  end

  def list_by_country_fuzzy(country) do
    list_kinokuniya_stores()
    |> Enum.filter(&(&1.country =~ ~r/#{country}/i))
  end

  def list_by_city(city) do
    :timer.sleep(2000)

    list_kinokuniya_stores()
    |> Enum.filter(&(&1.city == city))
  end

  def list_by_city_fuzzy(city) do
    list_kinokuniya_stores()
    |> Enum.filter(&(&1.city =~ ~r/#{city}/i))
  end

  def list_by_zip(zip) do
    :timer.sleep(2000)

    list_kinokuniya_stores()
    |> Enum.filter(&(&1.zip == zip))
  end

  def search_by_zip(zip) do
    from(s in KinokuniyaStore, where: s.zip == ^zip)
    |> Repo.all()
  end

  def search_by_city(city) do
    from(s in KinokuniyaStore, where: s.city == ^city)
    |> Repo.all()
  end

  @doc """
  Gets a single kinokuniya_store.

  Raises `Ecto.NoResultsError` if the Kinokuniya store does not exist.

  ## Examples

      iex> get_kinokuniya_store!(123)
      %KinokuniyaStore{}

      iex> get_kinokuniya_store!(456)
      ** (Ecto.NoResultsError)

  """
  def get_kinokuniya_store!(id), do: Repo.get!(KinokuniyaStore, id)

  @doc """
  Creates a kinokuniya_store.

  ## Examples

      iex> create_kinokuniya_store(%{field: value})
      {:ok, %KinokuniyaStore{}}

      iex> create_kinokuniya_store(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_kinokuniya_store(attrs \\ %{}) do
    %KinokuniyaStore{}
    |> KinokuniyaStore.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a kinokuniya_store.

  ## Examples

      iex> update_kinokuniya_store(kinokuniya_store, %{field: new_value})
      {:ok, %KinokuniyaStore{}}

      iex> update_kinokuniya_store(kinokuniya_store, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_kinokuniya_store(%KinokuniyaStore{} = kinokuniya_store, attrs) do
    kinokuniya_store
    |> KinokuniyaStore.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a kinokuniya_store.

  ## Examples

      iex> delete_kinokuniya_store(kinokuniya_store)
      {:ok, %KinokuniyaStore{}}

      iex> delete_kinokuniya_store(kinokuniya_store)
      {:error, %Ecto.Changeset{}}

  """
  def delete_kinokuniya_store(%KinokuniyaStore{} = kinokuniya_store) do
    Repo.delete(kinokuniya_store)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking kinokuniya_store changes.

  ## Examples

      iex> change_kinokuniya_store(kinokuniya_store)
      %Ecto.Changeset{data: %KinokuniyaStore{}}

  """
  def change_kinokuniya_store(%KinokuniyaStore{} = kinokuniya_store, attrs \\ %{}) do
    KinokuniyaStore.changeset(kinokuniya_store, attrs)
  end
end
