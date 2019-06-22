defmodule NfdWeb.FetchCollectionUtil do

  alias Nfd.API.PageAPI
  alias Nfd.API.ContentAPI

  alias Nfd.Util.Email
  
  alias Nfd.Meta
  alias Nfd.Meta.Comment
  alias Nfd.Meta.Page

  alias Nfd.Content
  alias Nfd.Content.Collection

  alias Nfd.Account.Subscriber

  def item_collection_practice(item, page_symbol, verified_slug, user_collections, client) do
    file_with_collection = Content.get_file_slug_with_collection!(verified_slug)
    has_paid_for_collection = Collection.has_paid_for_collection(file_with_collection.collection, user_collections)
    seven_week_awareness_challenge_symbol = generate_seven_week_awareness_challenge_symbol(item["vol"])
    subscriber_property = Email.collection_slug_to_type(file_with_collection.collection.slug)

    IO.inspect "hellosss"
    course = Map.merge(file_with_collection.collection, %{ has_paid_for_collection: has_paid_for_collection })

    case apply(ContentAPI, seven_week_awareness_challenge_symbol, [client, verified_slug]) do
      {:ok, response} ->
        %{file_with_collection: file_with_collection, course: course, has_paid_for_collection: has_paid_for_collection, subscriber_property: subscriber_property, additional_item: response.body["data"]}
      {:error, error} ->
        IO.inspect error
        %{file_with_collection: file_with_collection, course: course, has_paid_for_collection: has_paid_for_collection, subscriber_property: subscriber_property}
    end
  end

  def fetch_purchased_collections(user_collections, type, is_purchased) do
    Nfd.Content.list_collections_with_type(type)
      |> Enum.filter(fn (collection) ->
        if is_purchased do 
          Enum.find(user_collections.collections_access_list, &(&1.collection.id == collection.id))
        else
          !Enum.find(user_collections.collections_access_list, &(&1.collection.id == collection.id))
        end
      end)
  end

  def merge_collection(acc, client, content_symbol, item) do
    {:ok, response} = apply(PageAPI, content_symbol, [client])
    collections = response.body["data"][Atom.to_string(content_symbol)] |> Enum.reverse()
    { previous_item, next_item } = Page.previous_next_item(collections, item);
    Map.merge(acc, %{ content_symbol => collections, previous_item: previous_item, next_item: next_item })
  end

  def fetch_page_comments(acc, page_id) do
    Map.merge(acc, %{
      comments: Meta.list_collection_access_by_page_id(page_id)
        |> Comment.organise_date()
        |> Comment.organise_comments()
    })
  end

  def fetch_content_email(acc, client, symbol) do
    {:ok, response} = apply(PageAPI, symbol, [client])
    Map.put(acc, symbol, response.body["data"])
  end

  def fetch_subscriber_changeset(acc, symbol) do
    Map.put(acc, symbol, Subscriber.changeset(%Subscriber{}, %{}))
  end

  def fetch_single_dashboard_collection(acc, symbol, collection_slug, user_collections) do
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
      # TODO Here is where has_paid_for_collection should work. 

    has_paid_for_collection = Collection.has_paid_for_collection(sorted_collection, user_collections)

    Map.merge(acc, %{ symbol => sorted_collection |> Map.merge(%{ has_paid_for_collection: has_paid_for_collection }) })
  end

  defp generate_seven_week_awareness_challenge_symbol(vol) do
    case vol do
      "1" -> :seven_week_awareness_vol_1_single
      "2" -> :seven_week_awareness_vol_2_single
      "3" -> :seven_week_awareness_vol_3_single
      "4" -> :seven_week_awareness_vol_4_single
      "5" -> :seven_week_awareness_vol_5_single
      "6" -> :seven_week_awareness_vol_6_single
      _ -> nil
    end
  end

  def collection_slug_to_page_symbol(collection_slug) do 
    case collection_slug do 
      "seven-day-neverfap-deluxe-kickstarter" -> :seven_day_kickstarter_single
      "ten-day-meditation-primer" -> :ten_day_meditation_single
      "twenty-eight-day-awareness-challenge" -> :twenty_eight_day_awareness_single
      "seven-week-awareness-challenge-vol-1" -> :seven_week_awareness_vol_1_single
      "seven-week-awareness-challenge-vol-2" -> :seven_week_awareness_vol_2_single
      "seven-week-awareness-challenge-vol-3" -> :seven_week_awareness_vol_3_single
      "seven-week-awareness-challenge-vol-4" -> :seven_week_awareness_vol_4_single
    end
  end

  def page_symbol_to_collection_slug(page_symbol) do 
    case page_symbol do 
      :seven_day_kickstarter_single -> "seven-day-neverfap-deluxe-kickstarter"
      :ten_day_meditation_single -> "ten-day-meditation-primer"
      :twenty_eight_day_awareness_single -> "twenty-eight-day-awareness-challenge"
      :seven_week_awareness_vol_1_single -> "seven-week-awareness-challenge-vol-1"
      :seven_week_awareness_vol_2_single -> "seven-week-awareness-challenge-vol-2"
      :seven_week_awareness_vol_3_single -> "seven-week-awareness-challenge-vol-3"
      :seven_week_awareness_vol_4_single -> "seven-week-awareness-challenge-vol-4"
    end
  end

  def course_slug_to_up_to_count(course_slug) do 
    case course_slug do
      "seven-day-neverfap-deluxe-kickstarter" -> :seven_day_kickstarter_up_to_count
      "ten-day-meditation-primer" -> :ten_day_meditation_up_to_count
      "twenty-eight-day-awareness-challenge" -> :twenty_eight_day_awareness_up_to_count
      "seven-week-awareness-challenge-vol-1" -> :seven_week_awareness_vol_1_up_to_count
      "seven-week-awareness-challenge-vol-2" -> :seven_week_awareness_vol_2_up_to_count
      "seven-week-awareness-challenge-vol-3" -> :seven_week_awareness_vol_3_up_to_count
      "seven-week-awareness-challenge-vol-4" -> :seven_week_awareness_vol_4_up_to_count
    end
  end

  # defp generate_seven_week_awareness_challenge_title(vol) do
  #   case vol do
  #     "1" -> "7 Week Awareness Challenge Vol 1."
  #     "2" -> "7 Week Awareness Challenge Vol 2."
  #     "3" -> "7 Week Awareness Challenge Vol 3."
  #     "4" -> "7 Week Awareness Challenge Vol 4."
  #     "5" -> "7 Week Awareness Challenge Vol 5."
  #     "6" -> "7 Week Awareness Challenge Vol 6."
  #     _ -> nil
  #   end
  # end
end





