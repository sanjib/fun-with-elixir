defmodule LiveViewStudio.Repo.Migrations.CreateKinokuniyaStores do
  use Ecto.Migration

  def change do
    create table(:kinokuniya_stores) do
      add :address1, :string
      add :address2, :string
      add :city, :string
      add :state, :string
      add :zip, :string
      add :country, :string
      add :phone, :string
      add :opening_hours, :string

      timestamps()
    end

  end
end
