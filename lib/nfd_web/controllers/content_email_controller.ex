defmodule NfdWeb.ContentEmailController do
  use NfdWeb, :controller

  alias NfdWeb.Fetch
  
  def seven_day_kickstarter(conn, _params), do: Fetch.fetch_page(conn, :seven_day_kickstarter, "general.html", [:seven_day_kickstarter, :seven_day_kickstarter_changeset])  
  def seven_day_kickstarter_single(conn, %{"slug" => slug}), do: Fetch.fetch_content(conn, :seven_day_kickstarter_single, slug, "general.html", [:seven_day_kickstarter])  

  def ten_day_meditation(conn, _params), do: Fetch.fetch_page(conn, :ten_day_meditation, "general.html", [:ten_day_meditation])  
  def ten_day_meditation_single(conn, %{"slug" => slug}), do: Fetch.fetch_content(conn, :ten_day_meditation_single, slug, "general.html", [:ten_day_meditation])  

  def twenty_eight_day_awareness(conn, _params), do: Fetch.fetch_page(conn, :twenty_eight_day_awareness, "general.html", [:twenty_eight_day_awareness, :twenty_eight_day_awareness_changeset])  
  def twenty_eight_day_awareness_single(conn, %{"slug" => slug}), do: Fetch.fetch_content(conn, :twenty_eight_day_awareness_single, slug, "general.html", [:twenty_eight_day_awareness])  

end
