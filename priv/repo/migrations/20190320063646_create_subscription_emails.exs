defmodule Nfd.Repo.Migrations.CreateSubscriptionEmails do
  use Ecto.Migration

  def change do
    create table(:subscription_emails, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :day, :integer
      add :course, :string
      add :subscription_email, :string

      timestamps()
    end

  end
end
