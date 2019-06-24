defmodule Nfd.Content.File do
  use Ecto.Schema
  import Ecto.Changeset


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "files" do
    field :seed_id, :string
    field :type, :string
    field :specific_type, :string
    field :description, :string
    field :bucket_name, :string
    field :display_name, :string
    field :file_url, :string
    field :premium, :boolean, default: true
    field :slug, :string

    # field :collection_id, :binary_id
    belongs_to :collection, Nfd.Content.Collection

    timestamps()
  end

  @doc false
  def changeset(file, attrs) do
    file
    |> cast(attrs, [:seed_id, :slug, :display_name, :description, :type, :file_url, :premium])
    |> validate_required([:slug, :display_name, :description, :type, :file_url, :premium])
  end

  def changeset_with_collection(file, attrs) do
    file
    |> cast(attrs, [:seed_id, :slug, :display_name, :description, :type, :file_url, :premium, :collection_id])
    |> validate_required([:slug, :display_name, :description, :type, :premium, :collection_id])
    # |> cast_assoc()
  end
end
