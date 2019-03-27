defmodule Nfd.Account.CollectionAccess do
  use Ecto.Schema
  import Ecto.Changeset


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "collection_access" do
    field :collection_id, :string

    # field :user_id, :binary_id
    belongs_to :user, Nfd.Account.User

    timestamps()
  end

  @doc false
  def changeset(collection_access, attrs) do
    collection_access
    |> cast(attrs, [:collection_id, :user_id])
    |> validate_required([:collection_id, :user_id])
  end
end
