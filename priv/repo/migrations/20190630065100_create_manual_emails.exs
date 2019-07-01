defmodule Nfd.Repo.Migrations.CreateManualEmails do
  use Ecto.Migration

  def change do
    create table(:manual_emails, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :type, :text
      add :subject, :text
      add :message, :text

      timestamps()
    end

  end
end
