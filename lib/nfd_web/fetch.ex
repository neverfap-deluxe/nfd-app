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
        item_collections = FetchCollection.item_collections(response.body["data"], page_symbol, verified_slug, user_collections, client)
        content_collections = FetchCollection.content_collections(response.body["data"], collection_array, client)
        changeset_collections = FetchCollection.changeset_collections(response.body["data"], user_collections[:user], collection_array)
        
        fetch_response_ok(conn, page_view, response, user_collections, content_collections, changeset_collections, item_collections, page_symbol, page_layout, "content")
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

        fetch_response_ok(conn, page_view, response, user_collections, content_collections, changeset_collections, %{}, page_symbol, page_layout, "page")
      {:error, error} -> render_404_page(conn, error)
    end
  end

  def fetch_dashboard(conn, page_symbol, collection_slug, file_slug, collection_array) do
    user_collections = FetchCollection.user_collections(conn, [:user, :subscriber, :patreon_access, :collections_access_list])
    dashboard_collections = FetchCollection.dashboard_collections(conn, collection_array, user_collections, collection_slug, file_slug)
    api_key_collections = FetchCollection.api_key_collections(conn, collection_slug, user_collections, collection_array)

    IO.inspect user_collections.collections_access_list
    conn
      |> is_collection_complete(page_symbol, user_collections, dashboard_collections)
      |> is_file_paid_for(page_symbol, user_collections, dashboard_collections)
      |> put_flash(:info, (if user_collections.patreon_access.token_expired, do: "Welcome back!", else: "Your Patreon token has expired. Please Re-link your account."))
      |> put_view(NfdWeb.DashboardView)
      |> render("#{Atom.to_string(page_symbol)}.html", layout: {NfdWeb.LayoutView, "hub.html"}, user_collections: user_collections, dashboard_collections: dashboard_collections, api_key_collections: api_key_collections)
  end

  def fetch_response_ok(conn, page_view, response, user_collections, content_collections, changeset_collections, item_collections, page_symbol, page_layout, page_type) do
    Meta.increment_visit_count(response.body["data"])
    conn
      |> check_api_response_for_404(response.status)
      |> put_view(page_view)
      |> render("#{Atom.to_string(page_symbol)}.html", layout: { NfdWeb.LayoutView, page_layout }, item: response.body["data"], user_collections: user_collections, content_collections: content_collections, changeset_collections: changeset_collections, item_collections: item_collections, page_type: page_type)
  end

  def is_collection_complete(conn, page_symbol, user_collections, dashboard_collections) do
    case page_symbol do
        page_symbol when page_symbol in [:dashboard_course_collection, :dashboard_course_file] ->
          if dashboard_collections.course.status == "complete", do: conn, else: render_no_access_page(conn, "dashboard_no_complete.html")

        page_symbol when page_symbol in [:dashboard_ebook_collection, :dashboard_ebook_file] ->
          if dashboard_collections.ebook.status == "complete", do: conn, else: render_no_access_page(conn, "dashboard_no_complete.html")

        _ ->
          conn
    end
  end

  def is_file_paid_for(conn, page_symbol, user_collections, dashboard_collections) do
    case page_symbol do
      :dashboard_course_file ->
        has_patreon_access = user_collections.patreon_access.tier_access_list |> Enum.find(&(&1 == :courses_access))
        has_paid_for_collection = dashboard_collections.course.has_paid_for_collection
        if has_patreon_access or has_paid_for_collection, do: conn, else: render_no_access_page(conn, "dashboard_no_access.html")

      :dashboard_ebook_file ->
        has_patreon_access = user_collections.patreon_access.tier_access_list |> Enum.find(&(&1 == :ebooks_access))
        has_paid_for_collection = dashboard_collections.ebook.has_paid_for_collection
        if has_patreon_access or has_paid_for_collection, do: conn, else: render_no_access_page(conn, "dashboard_no_access.html")

      _ ->
        conn
    end
  end

  def render_no_access_page(conn, template) do
    conn
      |> put_view(NfdWeb.DashboardView)
      |> render(template, layout: {NfdWeb.LayoutView, "hub.html"})
  end

  def render_404_page(conn, error) do
    IO.inspect error
    conn
      |> put_view(NfdWeb.ErrorView)
      |> render("404.html")
  end

  defp check_api_response_for_404(conn, status) do
    if status != 200, do: render_404_page(conn, status), else: conn
  end
end
