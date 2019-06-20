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
  alias Nfd.BackBlaze

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
    IO.inspect(patreon)

    # Check which campaigns user is subscribed to
    {_count_property, subscribed_property} =
      Email.collection_slug_to_subscribed_property("general-newsletter")

    is_subscribed = Map.fetch!(subscriber, subscribed_property)

    info_message =
      if patreon.token_expired,
        do: "Welcome back!",
        else: "Your Patreon token has expired. Please Re-link your account."

    # Fetch collections
    collections =
      fetch_dashboard_collections(
        conn,
        collection_array,
        collections_access_list,
        collection_slug,
        file_slug,
        user,
        patreon
      )

    conn
    |> put_flash(:info, info_message)
    |> put_view(NfdWeb.DashboardView)
    |> render(
      "#{Atom.to_string(page_symbol)}.html",
      layout: {NfdWeb.LayoutView, "hub.html"},
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

end
