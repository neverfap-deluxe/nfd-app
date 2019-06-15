defmodule Nfd.Account.User do
  use Ecto.Schema
  use Pow.Ecto.Schema
  use Pow.Extension.Ecto.Schema,
    extensions: [PowResetPassword, PowEmailConfirmation]
  use PowAssent.Ecto.Schema

  import Ecto.Changeset

  alias Nfd.Account.Subscriber
  alias Nfd.Account.CollectionAccess

  alias Nfd.Meta.Comment

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    has_many :user_identities,
      Nfd.UserIdentities.UserIdentity,
      on_delete: :delete_all

    pow_user_fields()

    field :coaching_minutes, :integer
    field :display_name, :string
    field :first_name, :string
    field :last_name, :string
    field :avatar_url, :string
    field :slug, :string
    field :is_admin, :boolean, default: false

    field :patreon_linked, :boolean, default: false
    field :patreon_user_id, :string
    field :patreon_user_email, :string
    field :patreon_access_token, :string
    field :patreon_refresh_token, :string
    field :patreon_expires_in, :utc_datetime

    has_one :subscriber, Subscriber, on_delete: :delete_all
    has_many :collection_access, CollectionAccess, on_delete: :delete_all
    has_many :comments, Comment, on_delete: :delete_all

    timestamps()
  end

  def changeset(user, attrs) do
    user
      |> pow_changeset(attrs)
      |> pow_extension_changeset(attrs)
  end

  def id_changeset(user, attrs) do
    user
      |> cast(attrs, [:id])
  end

  def changeset_update(user, attrs) do
    user
    # |> pow_changeset(attrs)
    # |> pow_extension_changeset(attrs)
    |> cast(attrs, [
      :slug,
      :display_name, 
      :first_name, 
      :last_name, 
      :is_admin, 
      :coaching_minutes,
      :avatar_url,
      :patreon_linked,
      :patreon_user_id,
      :patreon_access_token,
      :patreon_refresh_token,
      :patreon_expires_in
    ])
    # |> validate_required([:slug, :display_name, :first_name, :last_name, :is_admin, :coaching_minutes])
  end

  # NOTE: This is unsafe and technically only for dev.
  def changeset_confirm_email(user, attrs) do
    user |> cast(attrs, [:email_confirmed_at])
  end
end
