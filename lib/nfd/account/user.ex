defmodule Nfd.Account.User do
  use Ecto.Schema
  use Pow.Ecto.Schema
  use Pow.Extension.Ecto.Schema,
    extensions: [PowResetPassword, PowEmailConfirmation]
  use PowAssent.Ecto.Schema

  import Ecto.Changeset

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
    field :is_admin, :boolean, default: false
    field :last_name, :string
    field :slug, :string

    has_one :subscriber, Nfd.Account.Subscriber, on_delete: :delete_all
    has_many :collection_access, Nfd.Account.CollectionAccess, on_delete: :delete_all

    timestamps()
  end

  def changeset(user, attrs) do

    if Map.has_key?(attrs, :email) do
      Nfd.EmailLogs.new_user_email_log(attrs.email)

      new_attr = Map.merge(attrs, %{ subscriber: %{ subscriber_email: attrs.email }})
      user
        |> pow_changeset(new_attr)
        |> pow_extension_changeset(new_attr)
        |> cast_assoc(:subscriber)
    else
      user
        |> pow_changeset(attrs)
        |> pow_extension_changeset(attrs)
        |> cast_assoc(:subscriber)
    end
  end

  def changeset_update(user, attrs) do
    user
    |> pow_changeset(attrs)
    |> pow_extension_changeset(attrs)
    |> cast(attrs, [:slug, :display_name, :first_name, :last_name, :is_admin, :coaching_minutes])
    |> validate_required([:slug, :display_name, :first_name, :last_name, :is_admin, :coaching_minutes])
  end

  # NOTE: This is unsafe and technically only for dev.
  def changeset_confirm_email(user, attrs) do
    user |> cast(attrs, [:email_confirmed_at])
  end
end
