defmodule Nfd.Content.Collection do
  use Ecto.Schema
  import Ecto.Changeset

  alias Nfd.Content

  alias NfdWeb.FetchCollectionUtil

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "collections" do
    field :seed_id, :string
    field :type, :string
    field :active_type, :string
    field :status, :string
    field :description, :string
    field :display_name, :string
    field :cover_image, :string
    field :benefit_list, :string
    field :premium, :boolean, default: false
    field :slug, :string
    field :price, :float
    field :stripe_sku, :string
    field :stripe_description, :string
    field :subscribed_property_string, :string

    has_many :files, Nfd.Content.File
    # has_many, :collection_accesses, Nfd.Account.CollectionAccess

    timestamps()
  end

  @doc false
  def changeset(collection, attrs) do
    collection
    |> cast(attrs, [:seed_id, :slug, :display_name, :status, :description, :type, :premium])
    |> validate_required([:slug, :display_name, :status, :description, :type, :premium])
  end

  def has_paid_for_collection(collection, user_collections) do
    user_collections.collections_access_list
      |> Enum.find(fn(list_collection) ->
        list_collection.collection_id == collection.id and list_collection.user_id == user_collections.user.id
      end)
  end

  def get_active_collections(subscriber) do
    [:free_active, :meditation_active, :awareness_active]
      |> Enum.reduce(%{}, fn active_property, acc ->
        subscribed_property = Map.get(subscriber, active_property)
        if subscribed_property != nil or subscribed_property != "" do
          collection = FetchCollectionUtil.page_symbol_subscribed_to_slug(subscribed_property) |> Content.get_collection_slug_with_files()
          acc |> Map.merge(%{ active_property => collection })
        else
          acc |> Map.merge(%{ active_property => false })
        end
      end)
  end

  def get_purchased_collections(user_collections, type, is_purchased) do
    Content.list_collections_with_type(type)
      |> Enum.filter(fn (collection) ->
        if is_purchased do
          Enum.find(user_collections.collections_access_list, &(&1.collection.id == collection.id))
        else
          !Enum.find(user_collections.collections_access_list, &(&1.collection.id == collection.id))
        end
      end)
  end

  def get_single_dashboard_collection(acc, symbol, collection_slug, user_collections) do
    collection = Content.get_collection_slug_with_files!(collection_slug)

    sorted_files =
      collection.files
        |> Enum.sort(fn(a, b) ->
          a_new = a.description |> String.split(" ") |> List.last() |> String.to_integer()
          b_new = b.description |> String.split(" ") |> List.last() |> String.to_integer()
          a_new > b_new
        end)
        |> Enum.reverse()

    sorted_collection = %{ collection | files: sorted_files }
    has_paid_for_collection = Collection.has_paid_for_collection(sorted_collection, user_collections)

    Map.merge(acc, %{ collection: sorted_collection |> Map.merge(%{ has_paid_for_collection: has_paid_for_collection }) })
  end
end
