defmodule NfdWeb.ContentEmailController do
  use NfdWeb, :controller

  alias Nfd.API
  alias Nfd.API.ContentEmail

  alias Nfd.Meta 
  alias Nfd.Account.Subscriber 

  plug :put_layout, "general.html"

  def twenty_eight_day_awareness(conn, _params) do
    page_type = "page"
    client = API.is_localhost(conn.host) |> API.api_client()

    case client |> ContentEmail.twenty_eight_day_awareness() do
      {:ok, response} ->
        Meta.increment_visit_count(response.body["data"])
        conn |> render("twenty_eight_day_awareness.html", item: response.body["data"], page_type: page_type)
      {:error, _error} ->
        conn 
        |> put_view(NfdWeb.ErrorView)
        |> render("404.html")
    end
  end

  def twenty_eight_day_awareness_single(conn, %{"day" => day}) do
    page_type = "page"
    client = API.is_localhost(conn.host) |> API.api_client()

    case client |> ContentEmail.twenty_eight_day_awareness_single(day) do
      {:ok, response} ->
        Meta.increment_visit_count(response.body["data"])
        conn |> render("twenty_eight_day_awareness_single.html", item: response.body["data"], page_type: page_type)
      {:error, _error} ->
        conn 
        |> put_view(NfdWeb.ErrorView)
        |> render("404.html")
    end
  end

  def seven_day_kickstarter(conn, _params) do
    page_type = "page"
    client = API.is_localhost(conn.host) |> API.api_client()

    seven_day_kickstarter_changeset = Subscriber.changeset(%Subscriber{}, %{})

    case client |> ContentEmail.seven_day_kickstarter() do
      {:ok, response} ->
        Meta.increment_visit_count(response.body["data"])
        conn |> render("seven_day_kickstarter.html", item: response.body["data"], seven_day_kickstarter_changeset: seven_day_kickstarter_changeset, page_type: page_type)
      {:error, _error} ->
        conn 
        |> put_view(NfdWeb.ErrorView)
        |> render("404.html")
    end
  end

  def seven_day_kickstarter_single(conn, %{"day" => day}) do
    page_type = "page"
    client = API.is_localhost(conn.host) |> API.api_client()

    case client |> ContentEmail.seven_day_kickstarter_single(day) do
      {:ok, response} ->
        Meta.increment_visit_count(response.body["data"])
        conn |> render("seven_day_kickstarter_single.html", item: response.body["data"], page_type: page_type)
      {:error, _error} ->
        conn 
        |> put_view(NfdWeb.ErrorView)
        |> render("404.html")
    end
  end

  def ten_day_meditation(conn, _params) do
    page_type = "page"
    client = API.is_localhost(conn.host) |> API.api_client()

    case client |> ContentEmail.ten_day_meditation() do
      {:ok, response} ->
        Meta.increment_visit_count(response.body["data"])
        conn |> render("ten_day_meditation.html", item: response.body["data"], page_type: page_type)
      {:error, _error} ->
        conn 
        |> put_view(NfdWeb.ErrorView)
        |> render("404.html")
    end
  end

  def ten_day_meditation_single(conn, %{"day" => day}) do
    page_type = "page"
    client = API.is_localhost(conn.host) |> API.api_client()

    case client |> ContentEmail.ten_day_meditation_single(day) do
      {:ok, response} ->
        Meta.increment_visit_count(response.body["data"])
        conn |> render("ten_day_meditation_single.html", item: response.body["data"], page_type: page_type)
      {:error, _error} ->
        conn 
        |> put_view(NfdWeb.ErrorView)
        |> render("404.html")
    end
  end
end
