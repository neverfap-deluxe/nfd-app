defmodule Nfd.Content.Collection do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "collections" do
    field :seed_id, :string
    field :type, :string
    field :status, :string
    field :description, :string
    field :display_name, :string
    field :premium, :boolean, default: false
    field :slug, :string
    field :price, :float

    has_many :files, Nfd.Content.File
    # TODO: has_many, collection_access

    timestamps()
  end

  @doc false
  def changeset(collection, attrs) do
    collection
    |> cast(attrs, [:seed_id, :slug, :display_name, :status, :description, :type, :premium])
    |> validate_required([:slug, :display_name, :status, :description, :type, :premium])
  end

  def has_paid_for_collection(collections_access_list, collection, user) do
    collections_access_list
      |> Enum.find(fn(list_collection) ->
        list_collection.collection_id == collection.id and list_collection.user_id == user.id
      end)
  end
end
