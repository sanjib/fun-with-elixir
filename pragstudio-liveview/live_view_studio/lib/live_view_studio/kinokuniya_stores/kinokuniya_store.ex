defmodule LiveViewStudio.KinokuniyaStores.KinokuniyaStore do
  use Ecto.Schema
  import Ecto.Changeset

  schema "kinokuniya_stores" do
    field :address1, :string
    field :address2, :string
    field :city, :string
    field :country, :string
    field :opening_hours, :string
    field :phone, :string
    field :state, :string
    field :zip, :string

    timestamps()
  end

  @doc false
  def changeset(kinokuniya_store, attrs) do
    kinokuniya_store
    |> cast(attrs, [:address1, :address2, :city, :state, :zip, :country, :phone, :opening_hours])
    |> validate_required([:address1, :address2, :city, :state, :zip, :country, :phone, :opening_hours])
  end
end
