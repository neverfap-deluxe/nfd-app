defmodule NfdWeb.PageController do
  use NfdWeb, :controller

  alias NfdWeb.API
  alias NfdWeb.API.Page
  alias NfdWeb.API.Content
  
  alias Nfd.Meta

  plug :put_layout, "general.html"

  def home(conn, _params) do
    page_type = "page"
    client = API.is_localhost(conn.host) |> API.api_client()
     
    case client |> Page.home() do
      {:ok, response} -> 
        Meta.increment_visit_count(response.body["data"])
        {:ok, articlesResponse} = client |> Content.articles()
          conn |> render("home.html", layout: {NfdWeb.LayoutView, "home.html"}, item: response.body["data"], articles: articlesResponse.body["data"]["articles"], page_type: page_type)
      {:error, _error} ->  # :econnrefused
        conn |> render("404.html")
    end
  end

  def guide(conn, _params) do
    page_type = "page"
    client = API.is_localhost(conn.host) |> API.api_client()

    case client |> Page.guide() do
      {:ok, response} ->
        Meta.increment_visit_count(response.body["data"])
        {:ok, articlesResponse} = client |> Content.articles()
        conn |> render("guide.html", item: response.body["data"], articles: articlesResponse.body["data"]["articles"], page_type: page_type)
      {:error, _error} ->
        conn |> render("404.html")
    end
  end

  def community(conn, _params) do
    page_type = "page"
    client = API.is_localhost(conn.host) |> API.api_client()

    case client |> Page.community() do
      {:ok, response} ->
        Meta.increment_visit_count(response.body["data"])
        {:ok, articlesResponse} = client |> Content.articles()
        conn |> render("community.html", item: response.body["data"], articles: articlesResponse.body["data"]["articles"], page_type: page_type)
      {:error, _error} ->
        conn |> render("404.html")
    end
  end

  def about(conn, _params) do
    page_type = "page"
    client = API.is_localhost(conn.host) |> API.api_client()

    case client |> Page.about() do
      {:ok, response} ->
        Meta.increment_visit_count(response.body["data"])
        conn |> render("about.html", item: response.body["data"], page_type: page_type)
      {:error, _error} ->
        conn |> render("404.html")
    end
  end

  def contact(conn, _params) do
    page_type = "page"
    client = API.is_localhost(conn.host) |> API.api_client()

    case client |> Page.contact() do
      {:ok, response} ->
        Meta.increment_visit_count(response.body["data"])
        conn |> render("contact.html", item: response.body["data"], page_type: page_type)
      {:error, _error} ->
        conn |> render("404.html")
    end
  end
  
  def disclaimer(conn, _params) do
    page_type = "page"
    client = API.is_localhost(conn.host) |> API.api_client()

    case client |> Page.disclaimer() do
      {:ok, response} ->
        Meta.increment_visit_count(response.body["data"])
        conn |> render("disclaimer.html", item: response.body["data"], page_type: page_type)
      {:error, _error} ->
        conn |> render("404.html")
    end
  end

  def privacy(conn, _params) do
    page_type = "page"
    client = API.is_localhost(conn.host) |> API.api_client()

    case client |> Page.privacy() do
      {:ok, response} ->
        Meta.increment_visit_count(response.body["data"])
        conn |> render("privacy.html", item: response.body["data"], page_type: page_type)
      {:error, _error} ->
        conn |> render("404.html")
    end
  end

  def account(conn, _params) do
    changeset = Pow.Plug.change_user(conn)

    render(conn, "account.html", changeset: changeset)
  end

  def four_oh_four(conn, %{ "four_oh_four" => four_oh_four}) do
    conn |> render("404.html")
  end
end
