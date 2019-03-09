defmodule Nfd.Repo.Migrations.CreatePages do
  use Ecto.Migration

  def change do
    create table(:pages, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :page_id, :string
      add :visit_count, :integer

      timestamps()
    end

  end
end
