defmodule NfdWeb.Fetch do
  use NfdWeb, :controller

  alias Nfd.Meta
  alias Nfd.Meta.Comment
  alias Nfd.Meta.Page

  alias Nfd.API
  alias Nfd.API.PageAPI
  alias Nfd.API.ContentAPI

  alias Nfd.Account
  alias Nfd.Account.Subscriber
  alias Nfd.Account.ContactForm

  alias NfdWeb.Redirects

  alias NfdWeb.FetchConn
  alias NfdWeb.FetchCollection
  alias NfdWeb.FetchCollectionUtil

  def fetch_page(conn, page_view, page_symbol, page_layout, collection_array) do
    client = API.is_localhost(conn.host) |> API.api_client()

    # FUTURE: Do we even need this, or is this covered in page_collections/content_collections? I feel like it should be in those things.
    case apply(PageAPI, page_symbol, [client]) do
      {:ok, response} ->
        user_collections = FetchCollection.user_collections(conn, [:user, :subscriber, :patreon_access, :collections_access_list])
        page_collections = FetchCollection.page_collections(client, collection_array)
        changeset_collections = FetchCollection.changeset_collections(response.body["data"], user_collections[:user], collection_array)

        conn
          |> FetchConn.check_api_response_for_404(response.status)
          |> Page.increment_visit_count(response.body["data"])
          |> put_view(page_view)
          |> render("#{Atom.to_string(page_symbol)}.html", layout: { NfdWeb.LayoutView, page_layout }, item: response.body["data"], user_collections: user_collections, page_collections: page_collections, changeset_collections: changeset_collections, page_type: "page")

      {:error, error} ->
        FetchConn.render_404_page(conn, error)
    end
  end

  def fetch_content(conn, page_view, page_symbol, slug, page_layout, collection_array) do
    content_slug = Redirects.redirect_content(conn, slug, Atom.to_string(page_symbol))
    client = API.is_localhost(conn.host) |> API.api_client()

    # FUTURE: Do we even need this, or is this covered in page_collections/content_collections? I feel like it should be in those things.
    case apply(ContentAPI, page_symbol, [client, content_slug]) do
      {:ok, response} ->
        user_collections = FetchCollection.user_collections(conn, [:user, :subscriber, :patreon_access, :collections_access_list])
        page_collections = FetchCollection.page_collections(client, collection_array)
        content_collections = FetchCollection.content_collections(client, response.body["data"], page_symbol, content_slug, user_collections, page_collections, collection_array)
        changeset_collections = FetchCollection.changeset_collections(response.body["data"], user_collections[:user], collection_array)

        
        # TODO: Look to see if getting kickstarter_single_pages will break if you’re not logged in and you don’t have a user.

        conn
          |> FetchConn.is_file_paid_for(page_symbol, user_collections, content_collections.collection, NfdWeb.PageView, "general.html", "error_page_no_access.html")
          |> FetchConn.are_they_up_to_day(page_symbol, response.body["data"], user_collections, content_collections.collection, NfdWeb.PageView, "general.html", "page_not_up_to.html")
          |> FetchConn.check_api_response_for_404(response.status)
          |> Page.increment_visit_count(response.body["data"])
          |> put_view(page_view)
          |> render("#{Atom.to_string(page_symbol)}.html", layout: { NfdWeb.LayoutView, page_layout }, item: response.body["data"], user_collections: user_collections, page_collections: page_collections, content_collections: content_collections, changeset_collections: changeset_collections, page_type: "content")

      {:error, error} ->
        FetchConn.render_404_page(conn, error)
    end
  end

  def fetch_dashboard(conn, page_symbol, collection_slug, file_slug, collection_array) do
    client = API.is_localhost(conn.host) |> API.api_client()

    user_collections = FetchCollection.user_collections(conn, [:user, :subscriber, :patreon_access, :collections_access_list, :active_collections])
    api_key_collections = FetchCollection.api_key_collections(conn, collection_slug, user_collections, collection_array)

    dashboard_collections = FetchCollection.dashboard_collections(collection_array, user_collections)

    conn
      |> put_flash(:info, (if user_collections.patreon_access.token_expired, do: "Welcome back!", else: "Your Patreon token has expired. Please Re-link your account."))
      |> put_view(NfdWeb.DashboardView)
      |> render("#{Atom.to_string(page_symbol)}.html", layout: {NfdWeb.LayoutView, "hub.html"}, user_collections: user_collections, dashboard_collections: dashboard_collections, api_key_collections: api_key_collections)
  end

  def fetch_dashboard_collection(conn, page_symbol, collection_slug, file_slug, collection_array) do
    client = API.is_localhost(conn.host) |> API.api_client()

    user_collections = FetchCollection.user_collections(conn, [:user, :subscriber, :patreon_access, :collections_access_list, :active_collections])
    api_key_collections = FetchCollection.api_key_collections(conn, collection_slug, user_collections, collection_array)

    dashboard_collections = FetchCollection.dashboard_collections(collection_array, user_collections)
    dashboard_collections_collection = FetchCollection.dashboard_collections_collection(client, collection_array, user_collections, collection_slug)

    conn
      |> FetchConn.is_collection_complete(page_symbol, user_collections, dashboard_collections_collection.collection, NfdWeb.DashboardView, "hub.html", "dashboard_no_complete.html")
      |> put_flash(:info, (if user_collections.patreon_access.token_expired, do: "Welcome back!", else: "Your Patreon token has expired. Please Re-link your account."))
      |> put_view(NfdWeb.DashboardView)
      |> render("#{Atom.to_string(page_symbol)}.html", layout: {NfdWeb.LayoutView, "hub.html"}, user_collections: user_collections, dashboard_collections: dashboard_collections, dashboard_collections_collection: dashboard_collections_collection, api_key_collections: api_key_collections)
  end

  def fetch_dashboard_file(conn, page_symbol, collection_slug, file_slug, collection_array) do
    client = API.is_localhost(conn.host) |> API.api_client()

    user_collections = FetchCollection.user_collections(conn, [:user, :subscriber, :patreon_access, :collections_access_list])
    api_key_collections = FetchCollection.api_key_collections(conn, collection_slug, user_collections, collection_array)

    dashboard_collections = FetchCollection.dashboard_collections(collection_array, user_collections)
    dashboard_collections_collection = FetchCollection.dashboard_collections_collection(client, collection_array, user_collections, collection_slug)
    dashboard_collections_file = FetchCollection.dashboard_collections_file(client, collection_array, user_collections, collection_slug, file_slug)

    conn
      |> FetchConn.is_collection_complete(page_symbol, user_collections, dashboard_collections_collection.collection, NfdWeb.DashboardView, "hub.html", "dashboard_no_complete.html")
      |> FetchConn.is_file_paid_for(page_symbol, user_collections, dashboard_collections_collection.collection, NfdWeb.DashboardView, "hub.html", "dashboard_no_access.html")
      |> FetchConn.are_they_up_to_day(page_symbol, Map.get(dashboard_collections_file, :file_content), user_collections, dashboard_collections_collection.collection, NfdWeb.DashboardView, "hub.html", "dashboard_no_access_up_top.html")
      |> put_flash(:info, (if user_collections.patreon_access.token_expired, do: "Welcome back!", else: "Your Patreon token has expired. Please Re-link your account."))
      |> put_view(NfdWeb.DashboardView)
      |> render("#{Atom.to_string(page_symbol)}.html", layout: {NfdWeb.LayoutView, "hub.html"}, user_collections: user_collections, dashboard_collections: dashboard_collections, dashboard_collections_collection: dashboard_collections_collection, dashboard_collections_file: dashboard_collections_file, api_key_collections: api_key_collections)
  end
end
