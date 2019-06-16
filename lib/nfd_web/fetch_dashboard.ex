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
          :collection_audio ->
            collection_audio = Content.get_collection_slug!(collection_slug)
            has_paid_for_collection = Collection.has_paid_for_collection(collections_access_list, collection_audio, user)
            Map.merge(acc, %{
              collection_audio: collection_audio,
              has_paid_for_collection: has_paid_for_collection
            })

          :collection_email ->
            collection_email = Content.get_collection_slug!(collection_slug)
            has_paid_for_collection = Collection.has_paid_for_collection(collections_access_list, collection_email, user)
            Map.merge(acc, %{
              collection_email: collection_email,
              has_paid_for_collection: has_paid_for_collection
            })

          :collections_audio ->
            Map.put(acc, :collections_audio, Content.list_audio_courses())

          :collections_email ->
            Map.put(acc, :collections_email, Content.list_email_campaigns())

          :collections_audio_file ->
            collections_audio_file = Content.get_file_slug!(file_slug)
            Map.put(acc, :collections_audio_file, collections_audio_file)

          :collections_email_file ->
            collections_email_file = Content.get_file_slug!(file_slug)
            Map.put(acc, :collections_email_file, collections_email_file)

            # No idea bout this, I'm sure it's relevant/useful.
            # collections_email_raw
            #   |> Enum.filter(fn(collection) ->
            #     collection_added_to_access_list = Enum.find(collections_access_list, fn(access_list) -> access_list.collection_id == collection.id end)
            #     if collection_added_to_access_list, do: false, else: true
            #   end)
            # collections_email_purchased = collections_email_raw |> Enum.filter()
            #   collections_email_available =
            #     collections_email_raw
            #       |> Enum.filter(fn(collection) ->
            #         collection_added_to_access_list = Enum.find(collections_access_list, fn(access_list) -> access_list.collection_id == collection.id end)
            #         if collection_added_to_access_list, do: true, else: false
            #       end)

            :stripe_api_key ->
              stripe_api_key = Stripe.get_relevant_stripe_key(conn.host)
              Map.put(acc, :stripe_api_key, stripe_api_key)

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
