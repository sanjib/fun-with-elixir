defmodule Refuge.Wildthings.Bear do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bears" do
    field :hibernate, :boolean, default: false
    field :name, :string
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(bear, attrs) do
    bear
    |> cast(attrs, [:name, :type, :hibernate])
    |> validate_required([:name, :type, :hibernate])
  end
end
