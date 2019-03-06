defmodule Nfd.Content.Collection do
  use Ecto.Schema
  import Ecto.Changeset


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "collections" do
    field :type, :string
    field :description, :string
    field :display_name, :string
    field :premium, :boolean, default: false
    field :slug, :string

    has_many :files, Nfd.Content.File

    timestamps()
  end

  @doc false
  def changeset(collection, attrs) do
    collection
    |> cast(attrs, [:slug, :display_name, :description, :type, :premium])
    |> validate_required([:slug, :display_name, :description, :type, :premium])
  end
end
