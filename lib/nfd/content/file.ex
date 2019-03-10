defmodule Nfd.Content.File do
  use Ecto.Schema
  import Ecto.Changeset


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "files" do
    field :seed_id, :string
    field :type, :string
    field :description, :string
    field :display_name, :string
    field :download_count, :string
    field :file_url, :string
    field :premium, :boolean, default: false
    field :slug, :string

    # field :collection_id, :binary_id
    belongs_to :collection, Nfd.Conten.Collection

    timestamps()
  end

  @doc false
  def changeset(file, attrs) do
    file
    |> cast(attrs, [:seed_id, :slug, :display_name, :description, :type, :file_url, :download_count, :premium])
    |> validate_required([:slug, :display_name, :description, :type, :file_url, :download_count, :premium])
  end
end
