defmodule Nfd.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema
  use Pow.Extension.Ecto.Schema,
    extensions: [PowResetPassword, PowEmailConfirmation]
  use PowAssent.Ecto.Schema

  schema "users" do
    has_many :user_identities,
      Nfd.UserIdentities.UserIdentity,
      on_delete: :delete_all

    pow_user_fields()

    # has_many :courses, Nfdraw @item["content"].Course

    timestamps()
  end

  def changeset(user_or_changeset, attrs) do
    user_or_changeset
    |> pow_changeset(attrs)
    |> pow_extension_changeset(attrs)
  end
end
