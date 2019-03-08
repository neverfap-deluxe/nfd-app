defmodule Nfd.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :slug, :string
      add :display_name, :string
      add :first_name, :string
      add :last_name, :string
      add :is_admin, :boolean, default: false, null: false
      add :coaching_minutes, :integer

      add :email, :string, null: false
      add :password_hash, :string

      timestamps()
    end
    create unique_index(:users, [:email])

  end
end
