defmodule Nfd.Repo.Migrations.CreateCollectionAccess do
  use Ecto.Migration

  def change do
    create table(:collection_access, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :collection_id, :string
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:collection_access, [:user_id])
  end
end
