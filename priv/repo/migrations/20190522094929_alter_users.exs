defmodule Nfd.Repo.Migrations.AlterComments do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :patreon_linked, :boolean, default: false
      add :patreon_user_id, :string
      add :patreon_user_email, :string
      add :patreon_access_token, :string
      add :patreon_refresh_token, :string
      add :patreon_expires_in, :utc_datetime
      add :avatar_url, :text
    end
  end
end
