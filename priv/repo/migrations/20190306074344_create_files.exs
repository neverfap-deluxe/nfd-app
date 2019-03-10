defmodule Nfd.Repo.Migrations.CreateFiles do
  use Ecto.Migration

  def change do
    create table(:files, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :seed_id, :string
      add :slug, :string
      add :type, :string
      add :display_name, :string
      add :description, :string
      add :file_url, :string
      add :download_count, :string
      add :premium, :boolean, default: false, null: false
      add :collection_id, references(:collections, on_delete: :nothing, type: :binary_id)

      timestamps()
    end
    create index(:files, [:collection_id, :seed_id])
  end
end
