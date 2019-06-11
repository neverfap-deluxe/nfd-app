defmodule Nfd.Meta.Comment do
  use Ecto.Schema
  import Ecto.Changeset
  
  alias Nfd.Account.User
  alias Nfd.Meta.Page

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "comments" do
    field :depth, :integer
    field :name, :string
    field :email, :string
    field :message, :string
    
    # has_one :parent_message_id, Comment, on_delete: :delete_all
    # has_one :user_id, User, on_delete: :delete_all
    # has_one :page_id, Page, on_delete: :delete_all

    field :parent_message_id, :string
    field :user_id, :binary_id
    field :page_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:depth, :email, :name, :message, :page_id, :parent_message_id])
    |> foreign_key_constraint(:parent_message_id)
    |> foreign_key_constraint(:page_id)
    |> validate_required([:depth, :email, :name, :message])
  end
end

