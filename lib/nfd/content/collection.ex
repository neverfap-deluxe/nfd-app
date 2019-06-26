defmodule Nfd.Content.Collection do
  use Ecto.Schema
  import Ecto.Changeset

  alias Nfd.Content
  alias Nfd.Content.Collection

  alias Nfd.BackBlaze

  alias NfdWeb.FetchCollectionUtil

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "collections" do
    field :seed_id, :string
    field :type, :string
    field :active_type, :string
    field :frequency, :string
    field :total_period, :integer
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

    has_many :subscription_emails, Nfd.Meta.SubscriptionEmail
    has_many :files, Nfd.Content.File
    # has_many, :collection_accesses, Nfd.Account.CollectionAccess

    # DECORATORS
    # up_to_count
    # has_paid_for_collection
    # current_collection_module

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
        if subscribed_property != nil do
          collection = subscribed_property |> FetchCollectionUtil.page_symbol_subscribed_to_slug() |> Content.get_collection_slug_with_files!()

          # NOTE: Collection Decorators - breaks wth email collections - possibly not in this context.
          up_to_count = subscriber |> Map.get(FetchCollectionUtil.course_slug_to_up_to_count(collection.slug))
          current_collection_module = collection.files |> Enum.find(&(&1.number == up_to_count))

          acc |> Map.merge(%{ active_property => collection |> Map.merge(%{ up_to_count: up_to_count, current_collection_module: current_collection_module }) })
        else
          acc |> Map.merge(%{ active_property => false })
        end
      end)
  end

  def get_purchased_collections(user_collections, collections, is_purchased) do
    collections
      |> Enum.filter(fn (collection) ->
        if is_purchased do
          Enum.find(user_collections.collections_access_list, &(&1.collection.id == collection.id))
        else
          !Enum.find(user_collections.collections_access_list, &(&1.collection.id == collection.id))
        end
      end)
  end

  def get_collection_with_decoration(collection, user_collections) do
    # NOTE: Collection Decorators - breaks wth email collections

    has_paid_for_collection = if collection.type == "course_collection", do: Collection.has_paid_for_collection(collection, user_collections), else: nil
    up_to_count = if collection.type == "course_collection", do: user_collections.subscriber |> Map.get(FetchCollectionUtil.course_slug_to_up_to_count(collection.slug)), else: nil
    # NOTE: This breaks if an epub file is also within a collection of type course, so I need to figure this out.
    current_collection_module = if collection.type == "course_collection", do: collection.files |> Enum.filter(&(&1.type != "ebook_file")) |> Enum.find(&(&1.number == up_to_count)), else: nil

    collection
      |> Map.merge(%{
        files:
          collection.files
            |> Enum.map(fn(file) ->
              file |> Map.merge(%{ b2_file_url: BackBlaze.get_file_contents(file.b2_file_name) }) # "" }) #
            end)
            |> Enum.sort(fn(a, b) -> a.number > b.number end)
            |> Enum.reverse()
      })
      |> Map.merge(%{ has_paid_for_collection: has_paid_for_collection })
      |> Map.merge(%{ up_to_count: up_to_count })
      |> Map.merge(%{ current_collection_module: current_collection_module })

  end

  def collection_decorator(decorator_array) do
    # decorator_array
    #   |> Enum.reduce(%{}, fn active_property, acc ->
    #     :up_to_count
    #     :collection_module
    #     :has_paid_for_collection
    #   end)
  end

end
