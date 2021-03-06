defmodule NfdWeb.FetchCollection do

  alias Nfd.Meta
  alias Nfd.Meta.Comment
  alias Nfd.Meta.Page

  alias Nfd.API
  alias Nfd.API.PageAPI
  alias Nfd.API.ContentAPI

  alias Nfd.Content
  alias Nfd.Content.Collection

  alias Nfd.Account
  alias Nfd.Account.Subscriber
  alias Nfd.Account.ContactForm
  alias Nfd.Account.CollectionAccess

  alias Nfd.BackBlaze
  alias Nfd.Patreon
  alias Nfd.Stripe
  alias Nfd.Paypal

  alias NfdWeb.FetchCollectionUtil

  alias Nfd.Util.Email

  def user_collections(conn, collection_array) do
    user = Pow.Plug.current_user(conn) |> Account.get_user_pow!()
    subscriber = user |> Subscriber.check_subscriber_exists()
    patreon_access = Patreon.fetch_patreon(conn.host, user)

    Enum.reduce(
      collection_array,
      %{},
      fn symbol, acc ->
        CollectionAccess.create_collection_access_for_free_courses(user)
        case symbol do
          :user -> acc |> Map.merge(%{ user: user })
          :subscriber -> acc |> Map.merge(%{ subscriber: subscriber })
          :patreon_access -> acc |> Map.merge(%{ patreon_access: patreon_access })
          :collections_access_list -> acc |> Map.merge(%{ collections_access_list: Map.get(user, :id) |> Account.list_collection_access_by_user_id() })
          :active_collections -> acc |> Map.merge(%{ active_collections: Collection.get_active_collections(subscriber) })
          :subscription_emails -> acc |> Map.merge(%{ subscription_emails: Meta.list_subscription_emails_by_subscriber_id(subscriber.id) })
          _ -> acc
        end
      end)
  end

  def page_collections(client, collection_array) do
    Enum.reduce(
      collection_array,
      %{},
      fn symbol, acc ->
        case symbol do
          symbol when symbol in [:articles, :practices, :quotes, :updates, :blogs, :podcasts, :meditations, :courses] ->
            case apply(PageAPI, symbol, [client]) do
              {:ok, response} ->
                acc |> Map.merge(%{ symbol => response.body["data"][Atom.to_string(symbol)] |> Enum.reverse() })

              {:error, error} ->
                IO.inspect error
                acc
            end

          symbol when symbol in [:seven_day_kickstarter, :ten_day_meditation, :twenty_eight_day_awareness, :seven_week_awareness_vol_1, :seven_week_awareness_vol_2, :seven_week_awareness_vol_3, :seven_week_awareness_vol_4] ->
            case apply(PageAPI, symbol, [client]) do
              {:ok, response} ->
                acc |> Map.merge(%{ symbol => response.body["data"] })

              {:error, error} ->
                IO.inspect error
                acc
            end

          _ ->
            acc
        end
    end)
  end

  def content_collections(client, item, page_symbol, content_slug, user_collections, page_collections, collection_array) do
    Enum.reduce(
      collection_array,
      %{},
      fn symbol, acc ->
        case symbol do
          symbol when symbol in [:seven_day_kickstarter_single, :ten_day_meditation_single, :twenty_eight_day_awareness_single, :seven_week_awareness_vol_1_single, :seven_week_awareness_vol_2_single, :seven_week_awareness_vol_3_single, :seven_week_awareness_vol_4_single] ->
            # FUTURE: This doesn't need full decoration, only part of the decoration is truly required.
            acc |> Map.merge(%{ collection: FetchCollectionUtil.page_symbol_to_collection_slug(page_symbol) |> Content.get_collection_slug_with_files!() |> Collection.get_collection_with_decoration(user_collections) })

          symbol when symbol in [:course, :article, :podcast, :quote, :meditation, :blog, :update] ->
            acc |> Map.merge(%{ collection: %{} })

          :practice ->
            # FUTURE: Also put in the actual practice here, so we don't need to collect it in the fetch thing via apply()
            file_with_collection = Content.get_file_slug_with_collection(content_slug)

            if file_with_collection do
              files = Content.list_files_with_collection_id_and_type(file_with_collection.collection.id, "audio_file")

              content_collections = %{
                file_with_collection: file_with_collection,
                has_paid_for_collection: file_with_collection.collection |> Collection.has_paid_for_collection(user_collections),
                subscribed_property: FetchCollectionUtil.collection_slug_to_subscribed_property(file_with_collection.collection.slug)
              }

              case apply(ContentAPI, FetchCollectionUtil.generate_seven_week_awareness_challenge_symbol(item["vol"]), [client, content_slug]) do
                {:ok, response} ->
                  acc |> Map.merge(%{ files: files, collection: file_with_collection.collection |> Map.merge(content_collections) |> Map.merge(%{ additional_item: response.body["data"]}) })

                {:error, _error} ->
                  acc |> Map.merge(%{ files: files, collection: file_with_collection.collection |> Map.merge(content_collections) |> Map.merge(%{ additional_item: %{}}) })
              end
            else
              acc |> Map.merge(%{ collection: nil })
            end

          :previous_next ->
            page_symbol = FetchCollectionUtil.content_symbol_to_page_symbol(page_symbol)
            { previous_item, next_item } = Map.get(page_collections, page_symbol) |> Page.previous_next_item(item)
            acc |> Map.merge(%{ previous_item: previous_item, next_item: next_item })

          :comments -> acc |> Map.merge(%{ comments: Comment.get_page_comments(item["page_id"]) })

          _ -> acc
        end
    end)
  end

  def changeset_collections(item, user, collection_array) do
    Enum.reduce(
      collection_array,
      %{},
      fn symbol, acc ->
        case symbol do
          symbol when symbol in [:seven_day_kickstarter_changeset, :ten_day_meditation_changeset, :twenty_eight_day_awareness_changeset, :seven_week_awareness_vol_1_changeset, :seven_week_awareness_vol_2_changeset, :seven_week_awareness_vol_3_changeset, :seven_week_awareness_vol_4_changeset] ->
            acc |> Map.merge(%{ symbol => Subscriber.get_subscriber_changeset(symbol) })

          :contact_form_changeset -> acc |> Map.merge(%{ contact_form_changeset: ContactForm.get_contact_form_changeset() })
          :comment_form_changeset -> acc |> Map.merge(%{ comment_form_changeset: Comment.get_comment_form_changeset(user, item) })

          _ -> acc
        end
    end)
  end

  def dashboard_collections(collection_array, user_collections) do
    ebooks = Content.list_ebooks_with_files()
    courses = Content.list_courses_with_files()

    Enum.reduce(
      collection_array,
      %{},
      fn symbol, acc ->
        case symbol do
          :ebooks -> acc |> Map.merge(%{ ebooks: ebooks })
          :courses -> acc |> Map.merge(%{ courses: courses })

          :purchased_ebooks -> acc |> Map.merge(%{ purchased_ebooks: Collection.get_purchased_collections(user_collections, ebooks, true) })
          :purchased_courses -> acc |> Map.merge(%{ purchased_courses: Collection.get_purchased_collections(user_collections, courses, true) })

          :not_purchased_ebooks -> acc |> Map.merge(%{ not_purchased_ebooks: Collection.get_purchased_collections(user_collections, ebooks, false) })
          :not_purchased_courses -> acc |> Map.merge(%{ not_purchased_courses: Collection.get_purchased_collections(user_collections, courses, false) })

          _ -> acc
        end
    end)
  end

  def dashboard_collections_collection(client, collection_array, user_collections, collection_slug) do
    # NOTE: Can maybe do some validation here, to see if it even gets the valid collection based on the collection_slug that has been passed.
    collection =
      Content.get_collection_slug_with_files!(collection_slug)

    Enum.reduce(
      collection_array,
      %{},
      fn symbol, acc ->
        case symbol do
          symbol when symbol in [:ebook, :course] ->
            acc |> Map.merge(%{ collection: Collection.get_collection_with_decoration(collection, user_collections) })

          :subscribed_property ->
            acc |> Map.merge(%{ subscribed_property: FetchCollectionUtil.collection_slug_to_subscribed_property(collection_slug) })

          :subscription_emails ->
            acc |> Map.merge(%{ subscription_emails: Meta.list_subscription_emails_by_config_course_type_and_subscriber_id(FetchCollectionUtil.collection_slug_to_config_course_type(collection.slug), user_collections.subscriber.id) })

          _ -> acc
        end
    end)
  end

  def dashboard_collections_file(client, collection_array, user_collections, collection_slug, file_slug) do
    file_with_collection =
      Content.get_collection_slug_with_files!(collection_slug)
        |> Map.get(:id)
        |> Content.get_file_slug_and_collection_id(file_slug)

    Enum.reduce(
      collection_array,
      %{},
      fn symbol, acc ->
        case symbol do
          symbol when symbol in [:ebook_file, :course_file] ->
            b2_file_url = BackBlaze.get_file_contents(file_with_collection.b2_file_name)
            # b2_file_url = ""

            if file_with_collection.type == "ebook_file" do
              acc |> Map.merge(%{ file: file_with_collection |> Map.merge(%{ b2_file_url: b2_file_url }), file_content: %{} })
            else
              case apply(ContentAPI, FetchCollectionUtil.collection_slug_to_page_symbol(collection_slug), [client, file_slug]) do
                {:ok, response} ->
                  acc |> Map.merge(%{ file: file_with_collection |> Map.merge(%{ b2_file_url: b2_file_url }), file_content: response.body["data"] })
                {:error, error} ->
                  IO.inspect error
                  acc |> Map.merge(%{ file: file_with_collection |> Map.merge(%{ b2_file_url: b2_file_url }), file_content: %{} })
              end
            end

          _ -> acc
        end
    end)
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
          :paypal_session -> acc |> Map.merge(%{ paypal_session: Paypal.create_paypal_session(user_collections.user, conn.host, collection_slug) })

          :patreon_auth_url -> acc |> Map.merge(%{ patreon_auth_url: Patreon.generate_relevant_patreon_auth_url(conn.host) })
          _ -> acc
        end
    end)
  end

end
