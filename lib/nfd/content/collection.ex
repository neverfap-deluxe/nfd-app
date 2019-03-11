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

    timestamps()
  end

  @doc false
  def changeset(collection, attrs) do
    collection
    |> cast(attrs, [:seed_id, :slug, :display_name, :status, :description, :type, :premium])
    |> validate_required([:slug, :display_name, :status, :description, :type, :premium])
  end
end