defmodule NfdWeb.FetchCollection do

  alias Nfd.Meta
  alias Nfd.Meta.Comment

  alias Nfd.API
  alias Nfd.API.Page
  alias Nfd.API.Content

  alias Nfd.Account
  alias Nfd.Account.Subscriber
  alias Nfd.Account.ContactForm

  alias FetchCollectionUtil

  def user_collections(conn, collection_array) do
    Enum.reduce(
      collection_array,
      %{},
      fn symbol, acc ->
        user = Pow.Plug.current_user(conn)
        CollectionAccess.create_collection_access_for_free_courses(user)
        case symbol do
          :user -> Map.put(acc, :user, user |> Account.get_user_pow!())
          :subscriber -> Map.put(acc, :subscriber, user |> Subscriber.check_subscriber_exists())

          :patreon_access ->
            patreon_access = Patreon.fetch_patreon(conn, user)
            Map.put(acc, :patreon_access, patreon_access)

          :collections_access_list ->
            collections_access_list = Account.list_collection_access_by_user_id(user.id)
            Map.put(acc, :collections_access_list, collections_access_list)

          _ ->
            acc
        end
      end)
  end

  def content_collections(item, collection_array, client) do
    Enum.reduce(
      collection_array,
      %{},
      fn symbol, acc ->
        case symbol do
          # CONTENT
          symbol when symbol in [:articles, :practices, :quotes, :updates, :blogs, :podcasts, :meditations, :courses] ->
            acc |> FetchCollectionUtil.merge_collection(client, symbol, item)

          # CONTENT EMAIL
          symbol when symbol in [:seven_day_kickstarter, :ten_day_meditation, :twenty_eight_day_awareness, :seven_week_awareness_vol_1, :seven_week_awareness_vol_2, :seven_week_awareness_vol_3, :seven_week_awareness_vol_4] ->
            acc |> FetchCollectionUtil.fetch_content_email(client, symbol)

          # CONTENT EMAIL CHANGESET
          symbol when symbol in [:seven_day_kickstarter_changeset, :ten_day_meditation_changeset, :twenty_eight_day_awareness_changeset, :seven_week_awareness_vol_1_changeset, :seven_week_awareness_vol_2_changeset, :seven_week_awareness_vol_3_changeset, :seven_week_awareness_vol_4_changeset] ->
            acc |> FetchCollectionUtil.fetch_subscriber_changeset(symbol)

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
          :comments ->
            comments = Meta.list_collection_access_by_page_id(item["page_id"])
              |> Comment.organise_date()
              |> Comment.organise_comments()

            Map.put(acc, :comments, comments)

          # MESSAGE CHANGESETS
          :contact_form_changeset ->
            contact_form_changeset = ContactForm.changeset(%ContactForm{}, %{name: "", email: "", message: ""})
            Map.put(acc, :contact_form_changeset, contact_form_changeset)

          :comment_form_changeset ->
            name = if Map.has_key?(user, :first_name), do: "#{user.first_name} #{user.last_name}", else: ""
            comment_form_changeset = Comment.changeset(%Comment{}, %{name: name, email: user[:email] or "", message: "", parent_message_id: "", user_id: user[:id] or "", depth: 0, page_id: item["page_id"]})
            Map.put(acc, :comment_form_changeset, comment_form_changeset)

          _ ->
            acc
        end
      end)
  end

  def dashboard_collections(conn, collection_array, collections_access_list, collection_slug, file_slug, user, patreon) do
    Enum.reduce(
      collection_array,
      %{},
      fn symbol, acc ->
        case symbol do
          # COLLECTION
          :ebooks -> Map.put(acc, :ebooks, Content.list_ebooks_with_files())
          :courses -> Map.put(acc, :courses, Content.list_courses_with_files())

          # SINGLE COLLECTION
          symbol when symbol in [:ebook, :course] ->
            collection = Content.get_collection_slug_with_files!(collection_slug)
            tier_access_collection = Patreon.tier_access_rights(patreon)
            has_paid_for_collection = Collection.has_paid_for_collection(collections_access_list, collection, user, patreon)
            Map.merge(acc, %{ symbol => collection, tier_access_collection: tier_access_collection, has_paid_for_collection: has_paid_for_collection })

          # SINGLE COLLECTION FILES
          symbol when symbol in [:ebook_file, :course_file] ->
            file = Content.get_file_slug!(file_slug)
            # backblaze_contents = BackBlaze.get_file_contents()
            Map.put(acc, symbol, file)

          _ ->
            acc
        end
      end
    )
  end

  def api_key_collections(conn, collection_array, collection_slug, user) do
    Enum.reduce(
      collection_array,
      %{},
      fn symbol, acc ->
        case symbol do
          :stripe_api_key ->
            stripe_api_key = Stripe.get_api_key(conn.host)
            Map.put(acc, :stripe_api_key, stripe_api_key)

          :stripe_session ->
            stripe_session = Stripe.create_stripe_session(user, conn.host, collection_slug)
            Map.put(acc, :stripe_session, stripe_session)

          :paypal_api_key ->
            paypal_api_key = Paypal.get_api_key(conn.host)
            Map.put(acc, :paypal_api_key, paypal_api_key)

          :patreon_auth_url ->
            Map.merge(acc, %{ patreon_auth_url: Patreon.generate_relevant_patreon_auth_url(conn.host) })

          _ ->
            acc
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
