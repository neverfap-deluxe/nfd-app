defmodule Nfd.Account.ContactForm do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "contact_form" do
    field :email, :string
    field :message, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(contact_form, attrs) do
    contact_form
    |> cast(attrs, [:name, :email, :message])
    |> validate_required([:name, :email, :message])
  end
end
