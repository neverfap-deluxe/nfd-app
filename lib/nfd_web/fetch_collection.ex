defmodule NfdWeb.FetchCollection do

  alias Nfd.Meta
  alias Nfd.Meta.Comment

  alias Nfd.API
  alias Nfd.API.PageAPI
  alias Nfd.API.ContentAPI

  alias Nfd.Account
  alias Nfd.Account.Subscriber
  alias Nfd.Account.ContactForm
  alias Nfd.Account.CollectionAccess

  alias Nfd.Patreon
  alias Nfd.Stripe
  alias Nfd.Paypal

  alias NfdWeb.FetchCollectionUtil

  alias Nfd.Util.Email

  def user_collections(conn, collection_array) do
    Enum.reduce(
      collection_array,
      %{},
      fn symbol, acc ->
        user = Pow.Plug.current_user(conn) |> Account.get_user_pow!()
        patreon_access = Patreon.fetch_patreon(conn.host, user)
        CollectionAccess.create_collection_access_for_free_courses(user)
        case symbol do
          :user -> acc |> Map.merge(%{ user: user })
          :subscriber -> acc |> Map.merge(%{ subscriber: user |> Subscriber.check_subscriber_exists() })
          :patreon_access -> acc |> Map.merge(%{ patreon_access: patreon_access })
          :collections_access_list -> acc |> Map.merge(%{ collections_access_list: Account.list_collection_access_by_user_id(Map.get(user, :id)) })
          _ -> acc
        end
      end)
  end

  def item_collections(item, page_symbol, verified_slug, user_collections, client) do
    case page_symbol do
      :article -> %{}
      :practice -> FetchCollectionUtil.item_collection_practice(item, page_symbol, verified_slug, user_collections, client)
      :course -> %{}
      :podcast -> %{}
      :quote -> %{}
      :meditation -> %{}
      :blog -> %{}
      :update -> %{}

      :seven_day_kickstarter_single -> %{course: FetchCollectionUtil.fetch_single_dashboard_collection(:course, verified_slug, user_collections)}
      :ten_day_meditation_single -> %{course: FetchCollectionUtil.fetch_single_dashboard_collection(:course, verified_slug, user_collections)}
      :twenty_eight_day_awareness_single -> %{course: FetchCollectionUtil.fetch_single_dashboard_collection(:course, verified_slug, user_collections)}

      :seven_week_awareness_vol_1_single -> %{course: FetchCollectionUtil.fetch_single_dashboard_collection(:course, verified_slug, user_collections)}
      :seven_week_awareness_vol_2_single -> %{course: FetchCollectionUtil.fetch_single_dashboard_collection(:course, verified_slug, user_collections)}
      :seven_week_awareness_vol_3_single -> %{course: FetchCollectionUtil.fetch_single_dashboard_collection(:course, verified_slug, user_collections)}
      :seven_week_awareness_vol_4_single -> %{course: FetchCollectionUtil.fetch_single_dashboard_collection(:course, verified_slug, user_collections)}

      _ -> %{}
    end
  end

  def content_collections(item, collection_array, client) do
    Enum.reduce(
      collection_array,
      %{},
      fn symbol, acc ->
        case symbol do
          symbol when symbol in [:articles, :practices, :quotes, :updates, :blogs, :podcasts, :meditations, :courses] ->
            acc |> FetchCollectionUtil.merge_collection(client, symbol, item)

          symbol when symbol in [:seven_day_kickstarter, :ten_day_meditation, :twenty_eight_day_awareness, :seven_week_awareness_vol_1, :seven_week_awareness_vol_2, :seven_week_awareness_vol_3, :seven_week_awareness_vol_4] ->
            acc |> FetchCollectionUtil.fetch_content_email(client, symbol)

          :comments -> acc |> FetchCollectionUtil.fetch_page_comments(item["page_id"])

          _ ->
            acc
        end
      end)
  end

  def changeset_collections(item, user, collection_array) do
    Enum.reduce(
      collection_array,
      %{},
      fn symbol, acc ->
        case symbol do

          :contact_form_changeset -> acc |> ContactForm.get_contact_form_changeset()
          :comment_form_changeset -> acc |> Comment.get_comment_form_changeset(user, item)

          symbol when symbol in [:seven_day_kickstarter_changeset, :ten_day_meditation_changeset, :twenty_eight_day_awareness_changeset, :seven_week_awareness_vol_1_changeset, :seven_week_awareness_vol_2_changeset, :seven_week_awareness_vol_3_changeset, :seven_week_awareness_vol_4_changeset] ->
            acc |> FetchCollectionUtil.fetch_subscriber_changeset(symbol)

          _ ->
            acc
        end
      end)
  end

  def dashboard_collections(conn, collection_array, user_collections, collection_slug, file_slug) do
    Enum.reduce(
      collection_array,
      %{},
      fn symbol, acc ->
        case symbol do
          :subscriber_property -> acc |> Map.merge(%{ subscriber_property: Email.collection_slug_to_type(collection_slug) })

          :ebooks -> acc |> Map.merge(%{ ebooks: Nfd.Content.list_ebooks_with_files() })
          :courses -> acc |> Map.merge(%{ courses: Nfd.Content.list_courses_with_files() })

          :purchased_ebooks -> acc |> Map.merge(%{ purchased_ebooks: FetchCollectionUtil.fetch_purchased_collections(user_collections, "ebook_collection", true) })
          :purchased_courses -> acc |> Map.merge(%{ purchased_courses: FetchCollectionUtil.fetch_purchased_collections(user_collections, "course_collection", true) })

          :not_purchased_ebooks -> acc |> Map.merge(%{ not_purchased_ebooks: FetchCollectionUtil.fetch_purchased_collections(user_collections, "ebook_collection", false) })
          :not_purchased_courses -> acc |> Map.merge(%{ not_purchased_courses: FetchCollectionUtil.fetch_purchased_collections(user_collections, "course_collection", false) })

          symbol when symbol in [:ebook, :course] ->
            acc |> FetchCollectionUtil.fetch_single_dashboard_collection(symbol, collection_slug, user_collections)

          symbol when symbol in [:ebook_file, :course_file] ->
            # TODO BackBlaze
            acc |> Map.merge(%{ symbol => Nfd.Content.get_file_slug!(file_slug) })

          :file_page_information -> 
            # collection_slug to 
            case apply(PageAPI, page_symbol, [client, file_slug]) do 
              {:ok, response} ->
                response.body["data"]
              {:error, error} -> 
                IO.inspect error 
                %{}
            end

          _ ->
            acc
        end
      end
    )
  end

  def api_key_collections(conn, collection_slug, user_collections, collection_array) do
    Enum.reduce(
      collection_array,
      %{},
      fn symbol, acc ->
        case symbol do
          :stripe_api_key -> acc |> Map.merge(%{ stripe_api_key: Stripe.get_api_key(conn.host) })
          :stripe_session -> acc |> Map.merge(%{ stripe_session: Stripe.create_stripe_session(user_collections.user, conn.host, collection_slug) })
          :paypal_api_key -> acc |> Map.merge(%{ paypal_api_key: Paypal.get_api_key(conn.host) })
          :patreon_auth_url -> acc |> Map.merge(%{ patreon_auth_url: Patreon.generate_relevant_patreon_auth_url(conn.host) })
          _ -> acc
        end
      end
    )
  end

end

# No idea bout this, I'm sure it's relevant/useful.
# courses_raw
#   |> Enum.filter(fn(collection) ->
#     collection_added_to_access_list = Enum.find(collections_access_list, fn(access_list) -> access_list.collection_id == collection.id end)
#     if collection_added_to_access_list, do: false, else: true
#   end)

# courses_purchased = courses_raw |> Enum.filter()
#   courses_available =
#     courses_raw
#       |> Enum.filter(fn(collection) ->
#         collection_added_to_access_list = Enum.find(collections_access_list, fn(access_list) -> access_list.collection_id == collection.id end)
#         if collection_added_to_access_list, do: true, else: false
#       end)
