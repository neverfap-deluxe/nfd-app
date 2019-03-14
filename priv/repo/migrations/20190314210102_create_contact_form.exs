defmodule Nfd.Repo.Migrations.CreateContactForm do
  use Ecto.Migration

  def change do
    create table(:contact_form, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :email, :string
      add :message, :string

      timestamps()
    end

  end
end
