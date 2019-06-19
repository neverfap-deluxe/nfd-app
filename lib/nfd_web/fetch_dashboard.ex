defmodule NfdWeb.FetchDashboard do
  use NfdWeb, :controller

  alias Nfd.Content
  alias Nfd.Content.Collection

  alias Nfd.EmailLogs

  alias Nfd.Account
  alias Nfd.Account.CollectionAccess
  alias Nfd.Account.Subscriber

  alias Nfd.Util.Email

  alias Nfd.Patreon
  alias Nfd.Stripe
  alias Nfd.Paypal

  use Timex

  def fetch_dashboard(conn, page_symbol, collection_slug, file_slug, collection_array) do
    # Get Subscriber and User
    user = Pow.Plug.current_user(conn) |> Account.get_user_pow!()
    subscriber = Pow.Plug.current_user(conn) |> Subscriber.check_subscriber_exists()

    # Subscribe to 7 Day Kickstarter
    CollectionAccess.create_collection_access_for_free_courses(user)

    # Get Collections Access List
    collections_access_list = Account.list_collection_access_by_user_id(user.id)

    # Validate Patreon
    patreon = Patreon.fetch_patreon(conn, user)

    IO.inspect patreon
    
    # Check which campaigns user is subscribed to
    { _count_property, subscribed_property } = Email.collection_slug_to_subscribed_property("general-newsletter")
    is_subscribed = Map.fetch!(subscriber, subscribed_property)

    info_message = if patreon.token_expired, do: "Welcome back!", else: "Your Patreon token has expired. Please Re-link your account."

    IO.inspect user

    # Fetch collections
    collections = fetch_dashboard_collections(conn, collection_array, collections_access_list, collection_slug, file_slug, user)
    conn
      |> put_flash(:info, info_message)
      |> put_view(NfdWeb.DashboardView)
      |> render(
        "#{Atom.to_string(page_symbol)}.html",
        layout: { NfdWeb.LayoutView, "hub.html" },
        user: user,
        subscriber: subscriber,
        collections_access_list: collections_access_list,
        is_subscribed: is_subscribed,
        subscribed_property: subscribed_property,
        collections: collections,
        is_valid_patron: patreon.is_valid_patron, 
        tier: patreon.tier, 
        token_expired: patreon.token_expired
      )
  end

  defp fetch_dashboard_collections(conn, collection_array, collections_access_list, collection_slug, file_slug, user) do
    Enum.reduce(
      collection_array,
      %{},
      fn x, acc ->
        case x do
          # COLLECTIONS
          :ebook ->
            ebook = Content.get_collection_slug!(collection_slug)
            has_paid_for_collection = Collection.has_paid_for_collection(collections_access_list, ebook, user)
            Map.merge(acc, %{
              ebook: ebook,
              has_paid_for_collection: has_paid_for_collection
            })

          :course ->
            course = Content.get_collection_slug!(collection_slug)
            has_paid_for_collection = Collection.has_paid_for_collection(collections_access_list, course, user)
            Map.merge(acc, %{
              course: course,
              has_paid_for_collection: has_paid_for_collection
            })

          :ebooks ->
            Map.put(acc, :ebooks, Content.list_ebooks())

          :courses ->
            Map.put(acc, :courses, Content.list_courses())

          :ebook_file ->
            ebook_file = Content.get_file_slug!(file_slug)
            Map.put(acc, :ebook_file, ebook_file)

          :course_file ->
            course_file = Content.get_file_slug!(file_slug)
            Map.put(acc, :course_file, course_file)

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
              Map.merge(acc, %{
                patreon_auth_url: Patreon.generate_relevant_patreon_auth_url(conn.host)
              })
          _ ->
            acc
        end
      end)
    end
end
