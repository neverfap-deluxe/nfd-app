defmodule NfdWeb.FetchConn do
  use NfdWeb, :controller

  alias NfdWeb.Fetch
  alias NfdWeb.FetchCollectionUtil

  def are_they_up_to_day(conn, page_symbol, responseBodyData, user_collections, dashboard_collections, view, layout, template) do
    day = responseBodyData["day"]

    case page_symbol do
      page_symbol when page_symbol in [:seven_day_kickstarter_single, :ten_day_meditation_single, :twenty_eight_day_awareness_single, :seven_week_awareness_vol_1_single, :seven_week_awareness_vol_2_single, :seven_week_awareness_vol_3_single, :seven_week_awareness_vol_4_single] ->
        if user_collections.subscriber |> Map.get(FetchCollectionUtil.page_symbol_to_up_to_count(page_symbol)) <= day, do: conn, else: Fetch.render_no_access_page(conn, dashboard_collections, view, layout, template)

      :dashboard_course_file -> 
        if user_collections.subscriber |> Map.get(FetchCollectionUtil.course_slug_to_up_to_count(dashboard_collections.collection.slug)) <= day, do: conn, else: Fetch.render_no_access_page(conn, dashboard_collections, view, layout, template)

      _ -> conn
    end
  end

  def is_collection_complete(conn, page_symbol, user_collections, dashboard_collections, view, layout, template) do
    case page_symbol do
      page_symbol when page_symbol in [:dashboard_course_collection, :dashboard_course_file] ->
        if dashboard_collections.collection.status == "complete", do: conn, else: Fetch.render_no_access_page(conn, dashboard_collections, view, layout, template)

      page_symbol when page_symbol in [:dashboard_ebook_collection, :dashboard_ebook_file] ->
        if dashboard_collections.collection.status == "complete", do: conn, else: Fetch.render_no_access_page(conn, dashboard_collections, view, layout, template)

      _ ->
        conn
    end
  end

  def is_file_paid_for(conn, page_symbol, user_collections, dashboard_collections, view, layout, template) do
    has_paid_for_collection = Map.get(dashboard_collections.collection, :has_paid_for_collection)

    case page_symbol do
      page_symbol when page_symbol in [:dashboard_course_file, :seven_day_kickstarter_single, :ten_day_meditation_single, :twenty_eight_day_awareness_single, :seven_week_awareness_vol_1_single, :seven_week_awareness_vol_2_single, :seven_week_awareness_vol_3_single, :seven_week_awareness_vol_4_single] ->
        has_patreon_access = user_collections.patreon_access.tier_access_list |> Enum.find(&(&1 == :courses_access))
        if !!has_patreon_access or !!has_paid_for_collection, do: conn, else: Fetch.render_no_access_page(conn, dashboard_collections, view, layout, template)

      page_symbol when page_symbol in [:dashboard_ebook_file, ] ->
        has_patreon_access = user_collections.patreon_access.tier_access_list |> Enum.find(&(&1 == :ebooks_access))
        if !!has_patreon_access or !!has_paid_for_collection, do: conn, else: Fetch.render_no_access_page(conn, dashboard_collections, view, layout, template)

      _ ->
        conn
    end
  end
end
