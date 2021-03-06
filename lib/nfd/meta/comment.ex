defmodule Nfd.Meta.Comment do
  # use Timex
  use Ecto.Schema
  import Ecto.Changeset

  alias Nfd.Meta
  alias Nfd.Meta.Page
  alias Nfd.Meta.Comment

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "comments" do
    field :depth, :integer
    field :name, :string
    field :email, :string
    field :message, :string
    # field :upvote_tally, :integer

    # so the reason why this is a field and not a reference is because the foreign key is a id and not page_id
    # although ideally it would be a reference, I'm just not sure how to do this.
    field :page_id, :binary_id
    field :parent_message_id, :binary_id
    field :user_id, :binary_id

    # okay, so you only need these belongs_to associations when you ALSO want to insert those objects.
    # belongs_to :parent_message, Nfd.Meta.Comment, foreign_key: :parent_message_id
    # belongs_to :user, User, foreign_key: :user_id

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:depth, :email, :name, :message, :page_id, :parent_message_id, :user_id])
    # |> cast_assoc(:parent_message, with: &Nfd.Meta.Comment.id_changeset/2)
    # |> cast_assoc(:user, with: &Nfd.Account.User.id_changeset/2)
    |> validate_required([:depth, :email, :name, :message, :page_id])
  end

  def id_changeset(comment, attrs) do
    comment
    |> cast(attrs, [:id])
  end

  def upvote_changeset(comment, attrs) do
    comment
    |> cast(attrs, [:upvote_tally])
  end

  def get_comment_form_changeset(user, item) do
    name = if Map.get(user, :first_name), do: "#{Map.get(user, :first_name)} #{Map.get(user, :last_name)}", else: ""
    Comment.changeset(%Comment{}, %{name: name, email: Map.get(user, :email), message: "", parent_message_id: "", user_id: Map.get(user, :id), depth: 0, page_id: item["page_id"]})
  end

  defp recursive_find_comments(comments, parent_comment, acc) do
    # Find the children of this parent
    comment_children = Enum.filter(comments, fn (child_comment) -> child_comment.parent_message_id == parent_comment.id end)
    parent_with_children = Map.put(parent_comment, :children, comment_children)

    # if not children, then just pass back to the top
    if Enum.empty?(parent_with_children.children) do
      parent_with_children
    else
      new_children =
        parent_with_children.children
          |> Enum.map(fn (comment_child) ->
            recursive_find_comments(comments, comment_child, acc)
          end)

        Map.put(parent_with_children, :children, new_children)
    end
  end

  def get_page_comments(page_id) do
    Meta.list_collection_access_by_page_id(page_id)
      |> organise_date()
      |> organise_comments()
  end

  defp organise_comments(comments) do
    comments
      |> Enum.filter(fn (comment) -> !comment.parent_message_id end)
      |> Enum.reduce(
        %{parents: []},
        fn parent_comment, acc ->
          parent_with_children = recursive_find_comments(comments, parent_comment, acc)
          %{parents: acc.parents ++ [parent_with_children]}
        end)
  end

  # https://hexdocs.pm/timex/Timex.Format.DateTime.Formatters.Default.html
  defp organise_date(comments) do
    comments
      |> Enum.map(fn (comment) ->
        commentDate = Timex.format!(comment.inserted_at, "{Mfull} {D}, {YYYY}") <> " at " <> Timex.format!(comment.inserted_at, "{h24}:{m} {am}")
        Map.merge(comment, %{
          inserted_at: commentDate
        })
      end)
  end

end

