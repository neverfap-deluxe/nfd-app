defmodule Nfd.Repo.Migrations.AlterSubscribers do
  use Ecto.Migration

  def change do
    alter table(:subscribers) do
      add :awareness_seven_week_vol_1_subscribed, :boolean, default: false, null: false
      add :awareness_seven_week_vol_1_count, :integer, default: 0, null: false
      add :awareness_seven_week_vol_2_subscribed, :boolean, default: false, null: false
      add :awareness_seven_week_vol_2_count, :integer, default: 0, null: false
      add :awareness_seven_week_vol_3_subscribed, :boolean, default: false, null: false
      add :awareness_seven_week_vol_3_count, :integer, default: 0, null: false
      add :awareness_seven_week_vol_4_subscribed, :boolean, default: false, null: false
      add :awareness_seven_week_vol_4_count, :integer, default: 0, null: false
    end
  end
end
