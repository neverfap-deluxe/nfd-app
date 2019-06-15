defmodule Nfd.Meta.Comment do
  use Ecto.Schema
  import Ecto.Changeset
  
  alias Nfd.Account.User
  alias Nfd.Meta.Page

  alias Nfd.Meta.Page
  alias Nfd.Account.User
  alias Nfd.Account.Subscriber

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "comments" do
    field :depth, :integer
    field :name, :string
    field :email, :string
    field :message, :string
    
<<<<<<< HEAD
    # so the reason why this is a field and not a reference is because the foreign key is a id and not page_id
    # although ideally it would be a reference, I'm just not sure how to do this.
    field :page_id, :binary_id 

    belongs_to :parent_message, Comment, foreign_key: :parent_message_id
    belongs_to :user, User, foreign_key: :user_id
=======
    # has_one :parent_message_id, Comment, on_delete: :delete_all
    # has_one :user_id, User, on_delete: :delete_all
    # has_one :page_id, Page, on_delete: :delete_all

    field :parent_message_id, :string
    field :user_id, :binary_id
    field :page_id, :binary_id
>>>>>>> production

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
<<<<<<< HEAD
    |> cast(attrs, [:depth, :email, :name, :message, :parent_message_id, :page_id, :user_id])
    |> foreign_key_constraint(:user_id)
    |> foreign_key_constraint(:parent_message_id)
    |> validate_required([:depth, :email, :name, :message, :page_id])
  end

  def organise_comments(comments) do
    comments
      |> Enum.filter(fn (comment) -> !comment.parent_message_id end)
      |> Enum.reduce(
        %{parents: []},
        fn reduce_comment, acc ->
          children_comments = recursive_find_comments(comments, reduce_comment, acc)
          %{parents: acc.parents ++ Map.put(reduce_comment, :children, children_comments)}
        end)
      |> IO.inspect comments
  end

  defp recursive_find_comments(comments, reduce_comment, acc) do
    # Find the children of the comment
    reduce_comment_children = Enum.filter(comments, fn (filter_comment) -> filter_comment.parent_message_id == reduce_comment.id end)

    # if children then add them to current comment
    if reduce_comment_children do
      reduce_comment_children
        |> Enum.map(fn (comment_child) ->
          new_comment_child = Map.put(reduce_comment, :children, reduce_comment_children)
          recursive_find_comments(comments, new_comment_child, acc)
        end)
    # if not children, then just pass back to the
    else
      %{child: reduce_comment}
    end
=======
    |> cast(attrs, [:depth, :email, :name, :message, :page_id, :parent_message_id])
    |> foreign_key_constraint(:parent_message_id)
    |> foreign_key_constraint(:page_id)
    |> validate_required([:depth, :email, :name, :message])
>>>>>>> production
  end
end

