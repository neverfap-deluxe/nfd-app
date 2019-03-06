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

    has_one :subscriber, Nfd.Account.Subscriber
    has_many :collection_access, Nfd.Account.CollectionAccess

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
      |> pow_changeset(attrs)
      |> pow_extension_changeset(attrs)
      |> cast(attrs, [:slug, :display_name, :first_name, :last_name, :is_admin, :coaching_minutes])
      |> validate_required([:slug, :display_name, :first_name, :last_name, :is_admin, :coaching_minutes])
  end

  # def changeset(user_or_changeset, attrs) do
  #   user_or_changeset
  #   |> pow_changeset(attrs)
  #   |> pow_extension_changeset(attrs)
  # end
end
