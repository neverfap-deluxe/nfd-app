defmodule Nfd.Repo.Migrations.AlterComments do
  use Ecto.Migration

  def change do
    alter table(:comments) do
      change :parent_message_id, references(:comments, on_delete: :nothing, type: :binary_id)
      field :patreon_linked, :boolean, default: false
      field :patreon_user_id, :string
      field :patreon_auth_token, :string
      field :patreon_refresh_token, :string
      field :patreon_expires_in, :string
    end
  end
end
