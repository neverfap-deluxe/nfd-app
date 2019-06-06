defmodule NfdWeb.ContentEmailController do
  use NfdWeb, :controller

  alias NfdWeb.Fetch
  alias NfdWeb.FetchCollection

  def seven_day_kickstarter(conn, _params), do: Fetch.fetch_page(conn, :seven_day_kickstarter, "general.html", FetchCollection.fetch_collections_array(:seven_day_kickstarter))
  def seven_day_kickstarter_single(conn, %{"slug" => slug}), do: Fetch.fetch_content(conn, :seven_day_kickstarter_single, slug, "general.html", FetchCollection.fetch_collections_array(:seven_day_kickstarter_single))

  def ten_day_meditation(conn, _params), do: Fetch.fetch_page(conn, :ten_day_meditation, "general.html", FetchCollection.fetch_collections_array(:ten_day_meditation))
  def ten_day_meditation_single(conn, %{"slug" => slug}), do: Fetch.fetch_content(conn, :ten_day_meditation_single, slug, "general.html", FetchCollection.fetch_collections_array(:ten_day_meditation_single))

  def twenty_eight_day_awareness(conn, _params), do: Fetch.fetch_page(conn, :twenty_eight_day_awareness, "general.html", FetchCollection.fetch_collections_array(:twenty_eight_day_awareness))
  def twenty_eight_day_awareness_single(conn, %{"slug" => slug}), do: Fetch.fetch_content(conn, :twenty_eight_day_awareness_single, slug, "general.html", FetchCollection.fetch_collections_array(:twenty_eight_day_awareness_single))
end
