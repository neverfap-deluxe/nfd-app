defmodule Nfd.Repo.Migrations.CreateSubscribers do
  use Ecto.Migration

  def change do
    create table(:subscribers, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :subscriber_email, :string
      add :subscribed, :boolean, default: false, null: false
      add :twenty_eight_day_awareness_subscribed, :boolean, default: false, null: false
      add :twenty_eight_day_awareness_count, :integer, default: 0, null: false
      add :seven_day_kickstarter_subscribed, :boolean, default: false, null: false
      add :seven_day_kickstarter_count, :integer, default: 0, null: false
      add :ten_day_meditation_subscribed, :boolean, default: false, null: false
      add :ten_day_meditation_count, :integer, default: 0, null: false

      add :three_day_awareness_subscribed, :boolean, default: false, null: false
      add :three_day_awareness_count, :integer, default: 0, null: false
      add :three_day_calmness_subscribed, :boolean, default: false, null: false
      add :three_day_calmness_count, :integer, default: 0, null: false
      add :three_day_meditation_subscribed, :boolean, default: false, null: false
      add :three_day_meditation_count, :integer, default: 0, null: false
  
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:subscribers, [:user_id, :subscriber_email])
  end
end
