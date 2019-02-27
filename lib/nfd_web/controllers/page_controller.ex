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
        IO.inspect(error)
        conn |> render("404.html")
    end
    
  end

  def article(conn, %{"slug" => slug}) do
    page_type = "content"
    case PageAPI.article(slug) do
      {:ok, response} ->
        IO.inspect(response.body["data"])
        {:ok, articlesResponse} = PageAPI.articles_content()
        conn |> render("article.html", item: response.body["data"], articles: articlesResponse.body["data"], page_type: page_type)
      {:error, error} ->
        conn |> render("404.html")
    end
  end

  def practices(conn, _params) do
    page_type = "page"
    case PageAPI.practices() do
      {:ok, response} ->
        {:ok, practicesResponse} = PageAPI.practices_content()
        conn |> render("practices.html", item: response.body["data"], practices: practicesResponse.body["data"], page_type: page_type)
      {:error, error} ->
        conn |> render("404.html")
    end
  end

  def practice(conn, %{"slug" => slug}) do
    page_type = "content"
    case PageAPI.practice(slug) do
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
        {:ok, coursesResponse} = PageAPI.courses_content()
        conn |> render("courses.html", item: response.body["data"], courses: coursesResponse.body["data"], page_type: page_type)
      {:error, error} ->
        conn |> render("404.html")
    end
  end

  def course(conn, %{"slug" => slug}) do
    page_type = "content"
    case PageAPI.course(slug) do
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

  def podcast(conn, %{"slug" => slug}) do
    page_type = "content"
    case PageAPI.podcast(slug) do
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

  

  def account(conn, _params) do
    changeset = Pow.Plug.change_user(conn)

    render(conn, "account.html", changeset: changeset)
  end

  def confirm_email_begin(conn, _params) do

    current_user = Pow.Plug.current_user(conn)

    conn
      |> put_flash(:user_email, current_user.email)
      |> render("confirm_email_begin.html")
  end

end
