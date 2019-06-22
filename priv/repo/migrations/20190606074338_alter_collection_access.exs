defmodule Nfd.Repo.Migrations.AlterCollectionAccess do
  use Ecto.Migration

  def change do
    alter table(:collections) do
      add :stripe_sku, :string
      add :stripe_description, :string
      add :subscribed_property_string, :string
      add :cover_image, :string
      add :benefit_list, :string
    end

    alter table(:files) do
      add :bucket_name, :string
    end

    alter table(:collection_access) do
      remove :collection_id
      add :collection_id, references(:collections, on_delete: :nothing, type: :binary_id)
    end

    alter table(:subscribers) do 
      add :seven_day_kickstarter_up_to_count, :integer
      add :ten_day_meditation_up_to_count, :integer
      add :twenty_eight_day_awareness_up_to_count, :integer
      add :awareness_seven_week_vol_1_up_to_count, :integer
      add :awareness_seven_week_vol_2_up_to_count, :integer
      add :awareness_seven_week_vol_3_up_to_count, :integer
      add :awareness_seven_week_vol_4_up_to_count, :integer
    end
  end
end
