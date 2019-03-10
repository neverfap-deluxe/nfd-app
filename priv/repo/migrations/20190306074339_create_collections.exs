defmodule Nfd.Repo.Migrations.CreateCollections do
  use Ecto.Migration

  def change do
    create table(:collections, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :seed_id, :string
      add :slug, :string
      add :type, :string
      add :display_name, :string
      add :description, :string
      add :status, :string
      add :price, :float
      add :premium, :boolean, default: false, null: false

      timestamps()
    end
    create unique_index(:collections, [:seed_id])
  end
end
