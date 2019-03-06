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


  # Content

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

  def articles(conn, _params) do
    page_type = "page"
    client = PageAPI.is_localhost(conn.host) |> PageAPI.api_client()

    case client |> PageAPI.articles() do
      {:ok, response} ->
        conn |> render("articles.html", item: response.body["data"], articles: response.body["data"]["articles"], page_type: page_type)
      {:error, _error} ->
        conn |> render("404.html")
    end
  end

  def article(conn, %{"slug" => slug}) do
    # TODO Check if it is draft. 

    page_type = "content"
    client = PageAPI.is_localhost(conn.host) |> PageAPI.api_client()

    case client |> PageAPI.article(slug) do
      {:ok, response} ->
        {:ok, articlesResponse} = client |> PageAPI.articles()
        conn |> render("article.html", item: response.body["data"], articles: articlesResponse.body["data"]["articles"], page_type: page_type)
      {:error, _error} ->
        conn |> render("404.html")
    end
  end

  def practices(conn, _params) do
    page_type = "page"
    client = PageAPI.is_localhost(conn.host) |> PageAPI.api_client()

    case client |> PageAPI.practices() do
      {:ok, response} ->
        conn |> render("practices.html", item: response.body["data"], practices: response.body["data"]["practices"], page_type: page_type)
      {:error, _error} ->
        conn |> render("404.html")
    end
  end

  def practice(conn, %{"slug" => slug}) do
    # TODO Check if it is draft. 

    page_type = "content"
    client = PageAPI.is_localhost(conn.host) |> PageAPI.api_client()

    case client |> PageAPI.practice(slug) do
      {:ok, response} ->
        conn |> render("practice.html", item: response.body["data"], page_type: page_type)
      {:error, _error} ->
        conn |> render("404.html")
    end
  end

  def courses(conn, _params) do
    page_type = "page"
    client = PageAPI.is_localhost(conn.host) |> PageAPI.api_client()

    case client |> PageAPI.courses() do
      {:ok, response} ->
        conn |> render("courses.html", item: response.body["data"], courses: response.body["data"]["courses"], page_type: page_type)
      {:error, _error} ->
        conn |> render("404.html")
    end
  end

  def course(conn, %{"slug" => slug}) do
    # TODO Check if it is draft. 

    page_type = "content"
    client = PageAPI.is_localhost(conn.host) |> PageAPI.api_client()

    case client |> PageAPI.course(slug) do
      {:ok, response} ->
        conn |> render("course.html", item: response.body["data"], page_type: page_type)
      {:error, _error} ->
        conn |> render("404.html")
    end
  end

  def podcasts(conn, _params) do
    page_type = "page"
    client = PageAPI.is_localhost(conn.host) |> PageAPI.api_client()

    case client |> PageAPI.podcasts() do
      {:ok, response} ->
        conn |> render("podcasts.html", item: response.body["data"], podcasts: response.body["data"]["podcasts"], page_type: page_type)
      {:error, _error} ->
        conn |> render("404.html")
    end
  end

  def podcast(conn, %{"slug" => slug}) do
    # TODO Check if it is draft. 

    page_type = "content"
    client = PageAPI.is_localhost(conn.host) |> PageAPI.api_client()

    case client |> PageAPI.podcast(slug) do
      {:ok, response} ->
        conn |> render("podcast.html", item: response.body["data"], page_type: page_type)
      {:error, _error} ->
        conn |> render("404.html")
    end
  end

  def quotes(conn, _params) do
    page_type = "page"
    client = PageAPI.is_localhost(conn.host) |> PageAPI.api_client()

    case client |> PageAPI.quotes() do
      {:ok, response} ->
        conn |> render("quotes.html", item: response.body["data"], item: response.body["data"]["quotes"], page_type: page_type)
      {:error, _error} ->
        conn |> render("404.html")
    end
  end

  def quote(conn, %{"slug" => slug}) do
    # TODO Check if it is draft. 

    page_type = "content"
    client = PageAPI.is_localhost(conn.host) |> PageAPI.api_client()

    case client |> PageAPI.quote(slug) do
      {:ok, response} ->
        conn |> render("quote.html", item: response.body["data"], page_type: page_type)
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


  # Special

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

  def account(conn, _params) do
    changeset = Pow.Plug.change_user(conn)

    render(conn, "account.html", changeset: changeset)
  end
end
