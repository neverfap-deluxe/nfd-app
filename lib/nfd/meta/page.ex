defmodule Nfd.Meta.Page do
  use Ecto.Schema
  import Ecto.Changeset


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "pages" do
    field :page_id, :string
    field :page_title, :string
    field :visit_count, :integer

    timestamps()
  end

  @doc false
  def changeset(page, attrs) do
    page
    |> cast(attrs, [:page_id, :visit_count, :page_title])
    |> validate_required([:page_id, :visit_count, :page_title])
  end
end
