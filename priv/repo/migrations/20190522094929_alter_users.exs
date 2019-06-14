defmodule Nfd.Repo.Migrations.AlterComments do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :patreon_linked, :boolean, default: false
      add :patreon_user_id, :string
      add :patreon_auth_token, :string
      add :patreon_refresh_token, :string
      add :patreon_expires_in, :string
    end
  end
end
