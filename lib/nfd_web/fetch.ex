defmodule NfdWeb.Fetch do
  use NfdWeb, :controller

  alias Nfd.Meta
  alias Nfd.Meta.Comment

  alias Nfd.API
  alias Nfd.API.PageAPI
  alias Nfd.API.ContentAPI

  alias Nfd.Account
  alias Nfd.Account.Subscriber
  alias Nfd.Account.ContactForm

  alias NfdWeb.Redirects

  alias NfdWeb.FetchCollection

  def fetch_content(conn, page_view, page_symbol, slug, page_layout, collection_array) do
    verified_slug = Redirects.redirect_content(conn, slug, Atom.to_string(page_symbol))
    client = API.is_localhost(conn.host) |> API.api_client()
    case apply(ContentAPI, page_symbol, [client, verified_slug]) do
      {:ok, response} ->
        user_collections = FetchCollection.user_collections(conn, [:user, :subscriber, :patreon_access, :collections_access_list])
        item_collections = FetchCollection.item_collections(conn, response.body["data"], page_symbol, verified_slug, user_collections, client)
        content_collections = FetchCollection.content_collections(response.body["data"], collection_array, client)
        changeset_collections = FetchCollection.changeset_collections(response.body["data"], user_collections[:user], collection_array)

        fetch_response_ok(conn, page_view, response, user_collections, content_collections, changeset_collections, page_symbol, page_layout, "content")
      {:error, error} ->
        render_404_page(conn, error)
    end
  end

  def fetch_page(conn, page_view, page_symbol, page_layout, collection_array) do
    client = API.is_localhost(conn.host) |> API.api_client()
    case apply(PageAPI, page_symbol, [client]) do
      {:ok, response} ->
        user_collections = FetchCollection.user_collections(conn, [:user, :subscriber, :patreon_access, :collections_access_list])
        content_collections = FetchCollection.content_collections(response.body["data"], collection_array, client)
        changeset_collections = FetchCollection.changeset_collections(response.body["data"], user_collections[:user], collection_array)

        fetch_response_ok(conn, page_view, response, user_collections, content_collections, changeset_collections, page_symbol, page_layout, "page")
      {:error, error} -> render_404_page(conn, error)
    end
  end

  def fetch_dashboard(conn, page_symbol, collection_slug, file_slug, collection_array) do
    user_collections = FetchCollection.user_collections(conn, [:user, :subscriber, :patreon_access, :collections_access_list])
    dashboard_collections = FetchCollection.dashboard_collections(conn, collection_array, user_collections, collection_slug, file_slug)
    api_key_collections = FetchCollection.api_key_collections(conn, collection_slug, user_collections, collection_array)

    # check to see if the file is paid for , if not then 

    conn
      |> put_flash(:info, (if user_collections.patreon_access.token_expired, do: "Welcome back!", else: "Your Patreon token has expired. Please Re-link your account."))
      |> put_view(NfdWeb.DashboardView)
      # |> is_file_paid_for()
      |> render("#{Atom.to_string(page_symbol)}.html", layout: {NfdWeb.LayoutView, "hub.html"}, user_collections: user_collections, dashboard_collections: dashboard_collections, api_key_collections: api_key_collections)
  end

  def fetch_response_ok(conn, page_view, response, user_collections, content_collections, changeset_collections, page_symbol, page_layout, page_type) do
    check_api_response_for_404(conn, response.status)
    Meta.increment_visit_count(response.body["data"])
    conn
      |> put_view(page_view)
      |> render("#{Atom.to_string(page_symbol)}.html", layout: { NfdWeb.LayoutView, page_layout }, item: response.body["data"], user_collections: user_collections, content_collections: content_collections, changeset_collections: changeset_collections, page_type: page_type)
  end

  def render_404_page(conn, error) do
    IO.inspect error
    conn
      |> put_view(NfdWeb.ErrorView)
      |> render("404.html")
  end

  defp check_api_response_for_404(conn, status) do
    if status != 200, do: render_404_page(conn, status)
  end
end
