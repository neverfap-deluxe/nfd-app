defmodule NfdWeb.PageController do
  use NfdWeb, :controller

  alias NfdWeb.PageAPI

  plug :put_layout, "general.html"

  def home(conn, _params) do
    page_type = "page"
    client = PageAPI.is_localhost(conn.host) |> PageAPI.api_client()
     
    case client |> PageAPI.home() do
      {:ok, response} -> 
        {:ok, articlesResponse} = client |> PageAPI.articles()        
          conn |> render("home.html", layout: {NfdWeb.LayoutView, "home.html"}, item: response.body["data"], articles: articlesResponse.body["data"]["articles"], page_type: page_type)
      {:error, _error} ->  # :econnrefused
        conn |> render("404.html")
    end
  end

  def guide(conn, _params) do
    page_type = "page"
    client = PageAPI.is_localhost(conn.host) |> PageAPI.api_client()

    case client |> PageAPI.guide() do
      {:ok, response} ->
        {:ok, articlesResponse} = client |> PageAPI.articles()
        conn |> render("guide.html", item: response.body["data"], articles: articlesResponse.body["data"]["articles"], page_type: page_type)
      {:error, _error} ->
        conn |> render("404.html")
    end
  end

  def about(conn, _params) do
    page_type = "page"
    client = PageAPI.is_localhost(conn.host) |> PageAPI.api_client()

    case client |> PageAPI.about() do
      {:ok, response} ->
        conn |> render("about.html", item: response.body["data"], page_type: page_type)
      {:error, _error} ->
        conn |> render("404.html")
    end
  end

  def contact(conn, _params) do
    page_type = "page"
    client = PageAPI.is_localhost(conn.host) |> PageAPI.api_client()

    case client |> PageAPI.contact() do
      {:ok, response} ->
        conn |> render("contact.html", item: response.body["data"], page_type: page_type)
      {:error, _error} ->
        conn |> render("404.html")
    end
  end
  
  def disclaimer(conn, _params) do
    page_type = "page"
    client = PageAPI.is_localhost(conn.host) |> PageAPI.api_client()

    case client |> PageAPI.disclaimer() do
      {:ok, response} ->
        conn |> render("disclaimer.html", item: response.body["data"], page_type: page_type)
      {:error, _error} ->
        conn |> render("404.html")
    end
  end

  def privacy(conn, _params) do
    page_type = "page"
    client = PageAPI.is_localhost(conn.host) |> PageAPI.api_client()

    case client |> PageAPI.privacy() do
      {:ok, response} ->
        conn |> render("privacy.html", item: response.body["data"], page_type: page_type)
      {:error, _error} ->
        conn |> render("404.html")
    end
  end

  def account(conn, _params) do
    changeset = Pow.Plug.change_user(conn)

    render(conn, "account.html", changeset: changeset)
  end
end
