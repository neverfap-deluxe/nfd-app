defmodule NfdWeb.FetchConn do
  use NfdWeb, :controller

  alias NfdWeb.Fetch
  alias NfdWeb.FetchCollectionUtil

  def are_they_up_to_day(conn, page_symbol, responseBodyData, user_collections, dashboard_collections_collection, view, layout, template) do
    case page_symbol do
      page_symbol when page_symbol in [:seven_day_kickstarter_single, :ten_day_meditation_single, :twenty_eight_day_awareness_single, :seven_week_awareness_vol_1_single, :seven_week_awareness_vol_2_single, :seven_week_awareness_vol_3_single, :seven_week_awareness_vol_4_single] ->
        day = responseBodyData["day"]
        if user_collections.subscriber |> Map.get(FetchCollectionUtil.page_symbol_to_up_to_count(page_symbol)) <= day, do: conn, else: render_no_access_page(conn, dashboard_collections_collection, view, layout, template)

      # NOTE: As we see here does not include :dashboard_ebook_file because that breaks
      :dashboard_course_file -> 
        day = responseBodyData["day"]
        if user_collections.subscriber |> Map.get(FetchCollectionUtil.course_slug_to_up_to_count(dashboard_collections_collection.collection.slug)) <= day, do: conn, else: render_no_access_page(conn, dashboard_collections_collection, view, layout, template)

      _ -> conn
    end
  end

  def is_collection_complete(conn, page_symbol, user_collections, dashboard_collections_collection, view, layout, template) do
    case page_symbol do
      page_symbol when page_symbol in [:dashboard_course_collection, :dashboard_course_file] ->
        if dashboard_collections_collection.collection.status == "complete", do: conn, else: render_no_access_page(conn, dashboard_collections_collection, view, layout, template)

      page_symbol when page_symbol in [:dashboard_ebook_collection, :dashboard_ebook_file] ->
        if dashboard_collections_collection.collection.status == "complete", do: conn, else: render_no_access_page(conn, dashboard_collections_collection, view, layout, template)

      _ ->
        conn
    end
  end

  def is_file_paid_for(conn, page_symbol, user_collections, dashboard_collections_collection, view, layout, template) do
    case page_symbol do
      page_symbol when page_symbol in [:dashboard_course_file, :seven_day_kickstarter_single, :ten_day_meditation_single, :twenty_eight_day_awareness_single, :seven_week_awareness_vol_1_single, :seven_week_awareness_vol_2_single, :seven_week_awareness_vol_3_single, :seven_week_awareness_vol_4_single] ->
        has_paid_for_collection = dashboard_collections_collection |> Map.get(:collection) |> Map.get(:has_paid_for_collection)
        has_patreon_access = user_collections.patreon_access.tier_access_list |> Enum.find(&(&1 == :courses_access))
        if !!has_patreon_access or !!has_paid_for_collection, do: conn, else: render_no_access_page(conn, dashboard_collections_collection, view, layout, template)

      page_symbol when page_symbol in [:dashboard_ebook_file, ] ->
        has_paid_for_collection = dashboard_collections_collection |> Map.get(:collection) |> Map.get(:has_paid_for_collection)
        has_patreon_access = user_collections.patreon_access.tier_access_list |> Enum.find(&(&1 == :ebooks_access))
        if !!has_patreon_access or !!has_paid_for_collection, do: conn, else: render_no_access_page(conn, dashboard_collections_collection, view, layout, template)

      _ ->
        conn
    end
  end

  # TODO: This needs to accomodate for both ebook and course links
  def render_no_access_page(conn, dashboard_collections_collection, view, layout, template) do
    conn
      |> put_view(view)
      |> render(template, layout: {NfdWeb.LayoutView, layout}, dashboard_collections_collection: dashboard_collections_collection)
  end

  def render_404_page(conn, error) do
    IO.inspect error
    conn
      |> put_view(NfdWeb.ErrorView)
      |> render("404.html")
  end

  def check_api_response_for_404(conn, status) do
    if status != 200, do: render_404_page(conn, status), else: conn
  end
end
