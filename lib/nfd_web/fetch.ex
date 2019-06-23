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
  alias NfdWeb.FetchCollectionUtil

  def fetch_content(conn, page_view, page_symbol, slug, page_layout, collection_array) do
    verified_slug = Redirects.redirect_content(conn, slug, Atom.to_string(page_symbol))
    client = API.is_localhost(conn.host) |> API.api_client()

    case apply(ContentAPI, page_symbol, [client, verified_slug]) do
      {:ok, response} ->

        user_collections = FetchCollection.user_collections(conn, [:user, :subscriber, :patreon_access, :collections_access_list])
        item_collections = FetchCollection.item_collections(response.body["data"], page_symbol, verified_slug, user_collections, client)
        content_collections = FetchCollection.content_collections(response.body["data"], collection_array, client)
        changeset_collections = FetchCollection.changeset_collections(response.body["data"], user_collections[:user], collection_array)
        
        conn
          |> is_file_paid_for(page_symbol, user_collections, item_collections, NfdWeb.PageView, "general.html", "error_page_no_access.html")
          |> are_they_up_to_day(page_symbol, response.body["data"], user_collections, item_collections, NfdWeb.PageView, "general.html", "page_not_up_to.html")
          |> fetch_response_ok(page_view, response, user_collections, content_collections, changeset_collections, item_collections, page_symbol, page_layout, "content")
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

        conn 
          |> fetch_response_ok(page_view, response, user_collections, content_collections, changeset_collections, %{}, page_symbol, page_layout, "page")
      {:error, error} -> render_404_page(conn, error)
    end
  end

  def fetch_dashboard(conn, page_symbol, collection_slug, file_slug, collection_array) do
    client = API.is_localhost(conn.host) |> API.api_client()

    user_collections = FetchCollection.user_collections(conn, [:user, :subscriber, :patreon_access, :collections_access_list])
    dashboard_collections = FetchCollection.dashboard_collections(conn, client, collection_array, user_collections, collection_slug, file_slug)
    api_key_collections = FetchCollection.api_key_collections(conn, collection_slug, user_collections, collection_array)
    
    conn
      |> put_flash(:info, (if user_collections.patreon_access.token_expired, do: "Welcome back!", else: "Your Patreon token has expired. Please Re-link your account."))
      |> put_view(NfdWeb.DashboardView)
      |> render("#{Atom.to_string(page_symbol)}.html", layout: {NfdWeb.LayoutView, "hub.html"}, user_collections: user_collections, dashboard_collections: dashboard_collections, api_key_collections: api_key_collections)
  end

  def fetch_dashboard_collection(conn, page_symbol, collection_slug, file_slug, collection_array) do
    client = API.is_localhost(conn.host) |> API.api_client()

    user_collections = FetchCollection.user_collections(conn, [:user, :subscriber, :patreon_access, :collections_access_list])
    dashboard_collections = FetchCollection.dashboard_collections(conn, client, collection_array, user_collections, collection_slug, file_slug)
    api_key_collections = FetchCollection.api_key_collections(conn, collection_slug, user_collections, collection_array)
    
    conn
      |> is_collection_complete(page_symbol, user_collections, dashboard_collections)
      |> put_flash(:info, (if user_collections.patreon_access.token_expired, do: "Welcome back!", else: "Your Patreon token has expired. Please Re-link your account."))
      |> put_view(NfdWeb.DashboardView)
      |> render("#{Atom.to_string(page_symbol)}.html", layout: {NfdWeb.LayoutView, "hub.html"}, user_collections: user_collections, dashboard_collections: dashboard_collections, api_key_collections: api_key_collections)
  end

  def fetch_dashboard_file(conn, page_symbol, collection_slug, file_slug, collection_array) do
    client = API.is_localhost(conn.host) |> API.api_client()

    user_collections = FetchCollection.user_collections(conn, [:user, :subscriber, :patreon_access, :collections_access_list])
    dashboard_collections = FetchCollection.dashboard_collections(conn, client, collection_array, user_collections, collection_slug, file_slug)
    api_key_collections = FetchCollection.api_key_collections(conn, collection_slug, user_collections, collection_array)
    
    conn
      |> is_collection_complete(page_symbol, user_collections, dashboard_collections)
      |> is_file_paid_for(page_symbol, user_collections, dashboard_collections, NfdWeb.DashboardView, "hub.html", "dashboard_no_access.html")
      |> are_they_up_to_day(page_symbol, Map.get(dashboard_collections, :file_page_information), user_collections, dashboard_collections, NfdWeb.DashboardView, "hub.html", "dashboard_no_access_up_top.html")
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

  def are_they_up_to_day(conn, page_symbol, responseBodyData, user_collections, dashboard_collections, view, layout, template) do
    day = responseBodyData["day"]
    IO.inspect page_symbol
    case page_symbol do
      page_symbol when page_symbol in [:seven_day_kickstarter_single, :ten_day_meditation_single, :twenty_eight_day_awareness_single, :seven_week_awareness_vol_1_single, :seven_week_awareness_vol_2_single, :seven_week_awareness_vol_3_single, :seven_week_awareness_vol_4_single] ->
        if user_collections.subscriber |> Map.get(FetchCollectionUtil.page_symbol_to_up_to_count(page_symbol)) <= day, do: conn, else: render_no_access_page(conn, dashboard_collections, view, layout, template)

      :dashboard_course_file -> if user_collections.subscriber |> Map.get(FetchCollectionUtil.course_slug_to_up_to_count(dashboard_collections.collection.slug)) <= day, do: conn, else: render_no_access_page(conn, dashboard_collections, view, layout, template)
      # :dashboard_ebook_file -> if user_collections.subscriber |> Map.get(FetchCollectionUtil.vol_to_up_to_count(responseBodyData)) <= day, do: conn, else: render_no_access_page(conn, dashboard_collections, view, layout, template)

      _ -> conn
    end
  end

  def is_collection_complete(conn, page_symbol, user_collections, dashboard_collections) do
    case page_symbol do
      page_symbol when page_symbol in [:dashboard_course_collection, :dashboard_course_file] ->
        if dashboard_collections.collection.status == "complete", do: conn, else: render_no_access_page(conn, dashboard_collections, NfdWeb.DashboardView, "hub.html", "dashboard_no_complete.html")

      page_symbol when page_symbol in [:dashboard_ebook_collection, :dashboard_ebook_file] ->
        if dashboard_collections.collection.status == "complete", do: conn, else: render_no_access_page(conn, dashboard_collections, NfdWeb.DashboardView, "hub.html", "dashboard_no_complete.html")

      _ ->
        conn
    end
  end

  def is_file_paid_for(conn, page_symbol, user_collections, dashboard_collections, view, layout, template) do
    has_paid_for_collection = Map.get(dashboard_collections.collection, :has_paid_for_collection)

    case page_symbol do
      page_symbol when page_symbol in [:dashboard_course_file, :seven_day_kickstarter_single, :ten_day_meditation_single, :twenty_eight_day_awareness_single, :seven_week_awareness_vol_1_single, :seven_week_awareness_vol_2_single, :seven_week_awareness_vol_3_single, :seven_week_awareness_vol_4_single] ->
        has_patreon_access = user_collections.patreon_access.tier_access_list |> Enum.find(&(&1 == :courses_access))
        if !!has_patreon_access or !!has_paid_for_collection, do: conn, else: render_no_access_page(conn, dashboard_collections, view, layout, template)

      page_symbol when page_symbol in [:dashboard_ebook_file, ] ->
        has_patreon_access = user_collections.patreon_access.tier_access_list |> Enum.find(&(&1 == :ebooks_access))
        if !!has_patreon_access or !!has_paid_for_collection, do: conn, else: render_no_access_page(conn, dashboard_collections, view, layout, template)

      _ ->
        conn
    end
  end

  def render_no_access_page(conn, dashboard_collections, view, layout, template) do
    conn
      |> put_view(view)
      |> render(template, layout: {NfdWeb.LayoutView, layout}, dashboard_collections: dashboard_collections)
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
