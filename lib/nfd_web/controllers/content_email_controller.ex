defmodule NfdWeb.ContentEmailController do
  use NfdWeb, :controller

  alias NfdWeb.PageAPI

  plug :put_layout, "general.html"

  def twenty_eight_day_awareness(conn, _params) do
    page_type = "page"
    client = PageAPI.is_localhost(conn.host) |> PageAPI.api_client()

    case client |> PageAPI.twenty_eight_day_awareness() do
      {:ok, response} ->
        conn |> render("twenty_eight_day_awareness.html", item: response.body["data"], page_type: page_type)
      {:error, _error} ->
        conn |> render("404.html")
    end
  end

  def twenty_eight_day_awareness_single(conn, _params) do
    page_type = "page"
    client = PageAPI.is_localhost(conn.host) |> PageAPI.api_client()

    case client |> PageAPI.twenty_eight_day_awareness() do
      {:ok, response} ->
        conn |> render("twenty_eight_day_awareness.html", item: response.body["data"], page_type: page_type)
      {:error, _error} ->
        conn |> render("404.html")
    end
  end

  def seven_day_kickstarter(conn, _params) do
    page_type = "page"
    client = PageAPI.is_localhost(conn.host) |> PageAPI.api_client()

    case client |> PageAPI.seven_day_kickstarter() do
      {:ok, response} ->
        conn |> render("seven_day_kickstarter.html", item: response.body["data"], page_type: page_type)
      {:error, _error} ->
        conn |> render("404.html")
    end
  end

  def seven_day_kickstarter_single(conn, _params) do
    page_type = "page"
    client = PageAPI.is_localhost(conn.host) |> PageAPI.api_client()

    case client |> PageAPI.seven_day_kickstarter() do
      {:ok, response} ->
        conn |> render("seven_day_kickstarter.html", item: response.body["data"], page_type: page_type)
      {:error, _error} ->
        conn |> render("404.html")
    end
  end

  def ten_day_meditation(conn, _params) do
    page_type = "page"
    client = PageAPI.is_localhost(conn.host) |> PageAPI.api_client()

    case client |> PageAPI.ten_day_meditation() do
      {:ok, response} ->
        conn |> render("ten_day_meditation.html", item: response.body["data"], page_type: page_type)
      {:error, _error} ->
        conn |> render("404.html")
    end
  end

  def ten_day_meditation_single(conn, _params) do
    page_type = "page"
    client = PageAPI.is_localhost(conn.host) |> PageAPI.api_client()

    case client |> PageAPI.ten_day_meditation() do
      {:ok, response} ->
        conn |> render("ten_day_meditation.html", item: response.body["data"], page_type: page_type)
      {:error, _error} ->
        conn |> render("404.html")
    end
  end
end
