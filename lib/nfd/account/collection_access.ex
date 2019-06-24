course_slug_to_up_to_countdefmodule Nfd.Account.CollectionAccess do
  use Ecto.Schema
  import Ecto.Changeset

  alias Nfd.Content
  alias Nfd.Account

  # NOTE: collection_id can refer to both collections and files.
  # It must be present for a file, otherwise they cannot have access to it.
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "collection_access" do
    # field :collection_id, :string
    # field :user_id, :binary_id

    belongs_to :user, Nfd.Account.User
    belongs_to :collection, Nfd.Content.Collection

    timestamps()
  end

  @doc false
  def changeset(collection_access, attrs) do
    collection_access
    |> cast(attrs, [:collection_id, :user_id])
    |> validate_required([:collection_id, :user_id])
  end

  # TODO : For when a new email is sent out.
  def create_collection_access() do
    IO.inspect("hello")
  end

  def create_collection_access_for_free_courses(nil), do: nil
  def create_collection_access_for_free_courses(user) do
    ["seven-day-neverfap-deluxe-kickstarter"]
    |> Enum.each(fn slug ->
      collection = Content.get_collection_slug_with_files!(slug)

      case Account.get_collection_access_by_user_id_and_collection_id(Map.get(user, :id), collection.id) do
        nil ->
          case Account.create_collection_access(%{user_id: user.id, collection_id: collection.id}) do
            {:ok, collection_access} -> collection_access
            {:error, _error} -> nil
          end

        _collection_access ->
          nil
      end
    end)
  end
end
