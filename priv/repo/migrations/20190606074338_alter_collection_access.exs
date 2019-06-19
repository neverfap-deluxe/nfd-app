defmodule Nfd.Repo.Migrations.AlterCollectionAccess do
  use Ecto.Migration

  def change do
    alter table(:collections) do
      add :stripe_sku, :string
      add :stripe_description, :string
    end

    # alter table(:collection_access) do
    #   add :sku
    # end
  end
end
