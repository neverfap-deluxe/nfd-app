defmodule NfdWeb.PageController do
  use NfdWeb, :controller

  alias NfdWeb.PageAPI

  plug :put_layout, "general.html"

  def home(conn, _params) do
    page_type = "page"

    case PageAPI.home() do
      {:ok, response} -> 
        {:ok, articlesResponse} = PageAPI.articles_content()
        conn |> render("home.html", layout: {NfdWeb.LayoutView, "home.html"}, item: response.body["data"], articles: articlesResponse.body["data"], page_type: page_type)
      {:error, error} ->  # :econnrefused
        IO.inspect(error)
        conn |> render("404.html")
    end
  end

  def about(conn, _params) do
    page_type = "page"
    case PageAPI.about() do
      {:ok, response} ->
        conn |> render("about.html", item: response.body["data"], page_type: page_type)
      {:error, error} ->
        conn |> render("404.html")
    end
    
  end

  def contact(conn, _params) do
    page_type = "page"
    case PageAPI.contact() do
      {:ok, response} ->
        conn |> render("contact.html", item: response.body["data"], page_type: page_type)
      {:error, error} ->
        conn |> render("404.html")
    end
  end


  # Content

  def guide(conn, _params) do
    page_type = "page"
    case PageAPI.guide() do
      {:ok, response} ->
        {:ok, articlesResponse} = PageAPI.articles_content()
        conn |> render("guide.html", item: response.body["data"], articles: articlesResponse.body["data"], page_type: page_type)
      {:error, error} ->
        conn |> render("404.html")
    end
    
  end

  def articles(conn, _params) do
    page_type = "page"
    case PageAPI.articles() do
      {:ok, response} ->
        {:ok, articlesResponse} = PageAPI.articles_content()
        conn |> render("articles.html", item: response.body["data"], articles: articlesResponse.body["data"], page_type: page_type)
      {:error, error} ->
        conn |> render("404.html")
    end
    
  end

  def article(conn, %{"name" => name}) do
    page_type = "content"
    case PageAPI.article(name) do
      {:ok, response} ->
        conn |> render("article.html", item: response.body["data"], page_type: page_type)
      {:error, error} ->
        conn |> render("404.html")
    end
  end

  def practices(conn, _params) do
    page_type = "page"
    case PageAPI.practices() do
      {:ok, response} ->
        conn |> render("practices.html", item: response.body["data"], page_type: page_type)
      {:error, error} ->
        conn |> render("404.html")
    end
  end

  def practice(conn, %{"name" => name}) do
    page_type = "content"
    case PageAPI.practice(name) do
      {:ok, response} ->
        conn |> render("practice.html", item: response.body["data"], page_type: page_type)
      {:error, error} ->
        conn |> render("404.html")
    end
  end

  def courses(conn, _params) do
    page_type = "page"
    case PageAPI.courses() do
      {:ok, response} ->
        conn |> render("courses.html", item: response.body["data"], page_type: page_type)
      {:error, error} ->
        conn |> render("404.html")
    end
  end

  def course(conn, %{"name" => name}) do
    page_type = "content"
    case PageAPI.course(name) do
      {:ok, response} ->
        conn |> render("course.html", item: response.body["data"], page_type: page_type)
      {:error, error} ->
        conn |> render("404.html")
    end
  end

  def podcasts(conn, _params) do
    page_type = "page"
    case PageAPI.podcasts() do
      {:ok, response} ->
        conn |> render("podcasts.html", item: response.body["data"], page_type: page_type)
      {:error, error} ->
        conn |> render("404.html")
    end
  end

  def podcast(conn, %{"name" => name}) do
    page_type = "content"
    case PageAPI.podcast(name) do
      {:ok, response} ->
        conn |> render("podcast.html", item: response.body["data"], page_type: page_type)
      {:error, error} ->
        conn |> render("404.html")
    end
  end

  def disclaimer(conn, _params) do
    page_type = "page"
    case PageAPI.disclaimer() do
      {:ok, response} ->
        conn |> render("disclaimer.html", item: response.body["data"], page_type: page_type)
      {:error, error} ->
        conn |> render("404.html")
    end
  end

  def privacy(conn, _params) do
    page_type = "page"
    case PageAPI.privacy() do
      {:ok, response} ->
        conn |> render("privacy.html", item: response.body["data"], page_type: page_type)
      {:error, error} ->
        conn |> render("404.html")
    end
  end

end
