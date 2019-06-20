defmodule Nfd.Repo.Migrations.AlterCollectionAccess do
  use Ecto.Migration

  def change do
    alter table(:collections) do
      add :stripe_sku, :string
      add :stripe_description, :string
      add :cover_image, :string
    end

    alter table(:files) do
      add :bucket_name, :string
    end
  end
end
