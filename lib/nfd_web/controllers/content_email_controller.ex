defmodule NfdWeb.ContentEmailController do
  use NfdWeb, :controller

  alias NfdWeb.Fetch
  alias NfdWeb.FetchAccess

  def seven_day_kickstarter(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.ContentEmailView, :seven_day_kickstarter, "general.html", FetchCollection.fetch_access_array(:seven_day_kickstarter))
  def seven_day_kickstarter_single(conn, %{"slug" => slug}), do: Fetch.fetch_content(conn, NfdWeb.ContentEmailView, :seven_day_kickstarter_single, slug, "general.html", FetchCollection.fetch_access_array(:seven_day_kickstarter_single))

  def ten_day_meditation(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.ContentEmailView, :ten_day_meditation, "general.html", FetchCollection.fetch_access_array(:ten_day_meditation))
  def ten_day_meditation_single(conn, %{"slug" => slug}), do: Fetch.fetch_content(conn, NfdWeb.ContentEmailView, :ten_day_meditation_single, slug, "general.html", FetchCollection.fetch_access_array(:ten_day_meditation_single))

  def twenty_eight_day_awareness(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.ContentEmailView, :twenty_eight_day_awareness, "general.html", FetchCollection.fetch_access_array(:twenty_eight_day_awareness))
  def twenty_eight_day_awareness_single(conn, %{"slug" => slug}), do: Fetch.fetch_content(conn, NfdWeb.ContentEmailView, :twenty_eight_day_awareness_single, slug, "general.html", FetchCollection.fetch_access_array(:twenty_eight_day_awareness_single))

  def seven_week_awareness_vol_1(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.ContentEmailView, :seven_week_awareness_vol_1, "general.html", FetchCollection.fetch_access_array(:seven_week_awareness_vol_1))
  def seven_week_awareness_vol_1_single(conn, %{"slug" => slug}), do: Fetch.fetch_content(conn, NfdWeb.ContentEmailView, :seven_week_awareness_vol_1_single, slug, "general.html", FetchCollection.fetch_access_array(:seven_week_awareness_vol_1_single))

  def seven_week_awareness_vol_2(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.ContentEmailView, :seven_week_awareness_vol_2, "general.html", FetchCollection.fetch_access_array(:seven_week_awareness_vol_2))
  def seven_week_awareness_vol_2_single(conn, %{"slug" => slug}), do: Fetch.fetch_content(conn, NfdWeb.ContentEmailView, :seven_week_awareness_vol_2_single, slug, "general.html", FetchCollection.fetch_access_array(:seven_week_awareness_vol_2_single))

  def seven_week_awareness_vol_3(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.ContentEmailView, :seven_week_awareness_vol_3, "general.html", FetchCollection.fetch_access_array(:seven_week_awareness_vol_3))
  def seven_week_awareness_vol_3_single(conn, %{"slug" => slug}), do: Fetch.fetch_content(conn, NfdWeb.ContentEmailView, :seven_week_awareness_vol_3_single, slug, "general.html", FetchCollection.fetch_access_array(:seven_week_awareness_vol_3_single))

  def seven_week_awareness_vol_4(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.ContentEmailView, :seven_week_awareness_vol_4, "general.html", FetchCollection.fetch_access_array(:seven_week_awareness_vol_4))
  def seven_week_awareness_vol_4_single(conn, %{"slug" => slug}), do: Fetch.fetch_content(conn, NfdWeb.ContentEmailView, :seven_week_awareness_vol_4_single, slug, "general.html", FetchCollection.fetch_access_array(:seven_week_awareness_vol_4_single))
end
