defmodule Nfd.Repo.Migrations.CreateCollections do
  use Ecto.Migration

  def change do
    create table(:collections, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :slug, :string
      add :type, :string
      add :display_name, :string
      add :description, :string
      add :status, :string
      add :premium, :boolean, default: false, null: false

      timestamps()
    end

  end
end
