defmodule NfdWeb.Fetch do
  use NfdWeb, :controller

  alias Nfd.Meta
  alias Nfd.Meta.Comment

  alias Nfd.API
  alias Nfd.API.Page
  alias Nfd.API.Content

  alias Nfd.Account
  alias Nfd.Account.Subscriber
  alias Nfd.Account.ContactForm

  alias NfdWeb.Redirects

  alias NfdWeb.FetchCollection

  def fetch_content(conn, page_view, page_symbol, slug, page_layout, collection_array) do
    verified_slug = Redirects.redirect_content(conn, slug, Atom.to_string(page_symbol))
    client = API.is_localhost(conn.host) |> API.api_client()
    case apply(Content, page_symbol, [client, verified_slug]) do
      {:ok, response} ->
        user_collections = FetchCollection.user_collections(conn, [:user, :subscriber, :patreon_access, :collections_access_list])
        content_collections = FetchCollection.content_collections(response.body["data"], collection_array, client)
        changeset_collections = FetchCollection.changeset_collections(response.body["data"], user, collection_array)

        fetch_response_ok(conn, user, page_view, response, user_collections, content_collections, changeset_collections, page_symbol, page_layout, "content")
      {:error, error} ->
        render_404_page(conn, error)
    end
  end

  def fetch_page(conn, page_view, page_symbol, page_layout, collection_array) do
    client = API.is_localhost(conn.host) |> API.api_client()
    case apply(Page, page_symbol, [client]) do
      {:ok, response} ->
        user_collections = FetchCollection.user_collections(conn, [:user, :subscriber, :patreon_access, :collections_access_list])
        content_collections = FetchCollection.content_collections(response.body["data"], collection_array, client)
        changeset_collections = FetchCollection.changeset_collections(response.body["data"], user, collection_array)

        fetch_response_ok(conn, user, page_view, response, user_collections, content_collections, changeset_collections, page_symbol, page_layout, "page")
      {:error, error} -> render_404_page(conn, error)
    end
  end

  def fetch_dashboard(conn, page_symbol, collection_slug, file_slug, collection_array) do
    user_collections = FetchCollection.user_collections(conn, [:user, :subscriber, :patreon_access, :collections_access_list])
    api_key_collections = FetchCollection.api_key_collections(conn, [stripe_api_key, :stripe_session, :paypal_api_key, :patreon_auth_url])

    conn
      |> put_flash(:info, (patreon.token_expired, do: "Welcome back!", else: "Your Patreon token has expired. Please Re-link your account."))
      |> put_view(NfdWeb.DashboardView)
      |> render("#{Atom.to_string(page_symbol)}.html", layout: {NfdWeb.LayoutView, "hub.html"}, user_collections: user_collections)
  end

  def fetch_response_ok(conn, user, page_view, response, user_collections, content_collections, changeset_collections, page_symbol, page_layout, page_type) do
    check_api_response_for_404(conn, response.status)
    Meta.increment_visit_count(response.body["data"])
    conn
      |> put_view(page_view)
      |> render("#{Atom.to_string(page_symbol)}.html", layout: { NfdWeb.LayoutView, page_layout }, item: response.body["data"], user_collections: user_collections, content_collections: content_collections, changeset_collections: changeset_collections, page_type: page_type, user: user)
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
