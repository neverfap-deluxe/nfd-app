defmodule NfdWeb.ContentController do
  use NfdWeb, :controller

  alias Nfd.API
  alias Nfd.API.Content

  alias Nfd.Meta
  alias Nfd.Account.Subscriber

  plug :put_layout, "general.html"

  def articles(conn, _params) do
    page_type = "page"
    client = API.is_localhost(conn.host) |> API.api_client()

    case client |> Content.articles() do
      {:ok, response} ->
        Meta.increment_visit_count(response.body["data"])
        conn |> render("articles.html", item: response.body["data"], articles: response.body["data"]["articles"], page_type: page_type)
      {:error, _error} ->
        render_404_page(conn)
    end
  end

  def article(conn, %{"slug" => slug}) do
    page_type = "content"
    client = API.is_localhost(conn.host) |> API.api_client()

    case client |> Content.article(slug) do
      {:ok, response} ->
        check_api_response_for_404(conn, response.status)
        Meta.increment_visit_count(response.body["data"])
        if response.body["data"]["draft"] == false do 
          {:ok, articlesResponse} = client |> Content.articles()

          { previousArticle, nextArticle } = getPreviousNextArticle(articlesResponse.body["data"]["articles"], response.body["data"]);
          seven_day_kickstarter_changeset = Subscriber.changeset(%Subscriber{}, %{})

          conn |> render("article.html", item: response.body["data"], articles: articlesResponse.body["data"]["articles"], seven_day_kickstarter_changeset: seven_day_kickstarter_changeset, previousArticle: previousArticle, nextArticle: nextArticle, page_type: page_type)  
        else 
          render_404_page(conn)
        end
      {:error, _error} ->
        render_404_page(conn)
    end
  end

  def practices(conn, _params) do
    page_type = "page"
    client = API.is_localhost(conn.host) |> API.api_client()

    case client |> Content.practices() do
      {:ok, response} ->
        Meta.increment_visit_count(response.body["data"])
        conn |> render("practices.html", item: response.body["data"], practices: response.body["data"]["practices"], page_type: page_type)
      {:error, _error} ->
        render_404_page(conn)
    end
  end

  def practice(conn, %{"slug" => slug}) do
    page_type = "content"
    client = API.is_localhost(conn.host) |> API.api_client()

    case client |> Content.practice(slug) do
      {:ok, response} ->
        check_api_response_for_404(conn, response.status)
        Meta.increment_visit_count(response.body["data"])
        if response.body["data"]["draft"] == false do 
          {:ok, articlesResponse} = client |> Content.articles()
          {:ok, practicesResponse} = client |> Content.practices()

          { previousArticle, nextArticle } = getPreviousNextArticle(practicesResponse.body["data"]["practices"], response.body["data"]);
          seven_day_kickstarter_changeset = Subscriber.changeset(%Subscriber{}, %{})
          
          conn |> render("practice.html", item: response.body["data"], articles: articlesResponse.body["data"]["articles"], practices: practicesResponse.body["data"]["practices"], seven_day_kickstarter_changeset: seven_day_kickstarter_changeset, previousArticle: previousArticle, nextArticle: nextArticle, page_type: page_type)
        else
          render_404_page(conn)
        end
      {:error, _error} ->
        render_404_page(conn)
    end
  end

  def courses(conn, _params) do
    page_type = "page"
    client = API.is_localhost(conn.host) |> API.api_client()

    case client |> Content.courses() do
      {:ok, response} ->
        Meta.increment_visit_count(response.body["data"])
        conn |> render("courses.html", item: response.body["data"], courses: response.body["data"]["courses"], page_type: page_type)
      {:error, _error} ->
        render_404_page(conn)
    end
  end

  def course(conn, %{"slug" => slug}) do
    page_type = "content"
    client = API.is_localhost(conn.host) |> API.api_client()

    case client |> Content.course(slug) do
      {:ok, response} ->
        check_api_response_for_404(conn, response.status)
        Meta.increment_visit_count(response.body["data"])
        if response.body["data"]["draft"] == false do 
          {:ok, articlesResponse} = client |> Content.articles()
          {:ok, practicesResponse} = client |> Content.practices()
          conn |> render("course.html", item: response.body["data"], articles: articlesResponse.body["data"]["articles"], practices: practicesResponse.body["data"]["practices"], page_type: page_type)
        else
          render_404_page(conn)
        end
      {:error, _error} ->
          render_404_page(conn)
    end
  end

  def podcasts(conn, _params) do
    page_type = "page"
    client = API.is_localhost(conn.host) |> API.api_client()

    case client |> Content.podcasts() do
      {:ok, response} ->
        Meta.increment_visit_count(response.body["data"])
        conn |> render("podcasts.html", item: response.body["data"], podcasts: response.body["data"]["podcasts"], page_type: page_type)
      {:error, _error} ->
        render_404_page(conn)
    end
  end

  def podcast(conn, %{"slug" => slug}) do
    page_type = "content"
    client = API.is_localhost(conn.host) |> API.api_client()

    case client |> Content.podcast(slug) do
      {:ok, response} ->
        check_api_response_for_404(conn, response.status)
        Meta.increment_visit_count(response.body["data"])
        if response.body["data"]["draft"] == false do 
          conn |> render("podcast.html", item: response.body["data"], page_type: page_type)
        else 
          render_404_page(conn)
        end
      {:error, _error} ->
        render_404_page(conn)
    end
  end

  def quotes(conn, _params) do
    page_type = "page"
    client = API.is_localhost(conn.host) |> API.api_client()

    case client |> Content.quotes() do
      {:ok, response} ->
        Meta.increment_visit_count(response.body["data"])
        conn |> render("quotes.html", item: response.body["data"], item: response.body["data"]["quotes"], page_type: page_type)
      {:error, _error} ->
        render_404_page(conn)
    end
  end

  def quote(conn, %{"slug" => slug}) do
    page_type = "content"
    client = API.is_localhost(conn.host) |> API.api_client()

    case client |> Content.quote(slug) do
      {:ok, response} ->
        check_api_response_for_404(conn, response.status)
        Meta.increment_visit_count(response.body["data"])
        if response.body["data"]["draft"] == false do 
          conn |> render("quote.html", item: response.body["data"], page_type: page_type)
        else
          render_404_page(conn)
        end
      {:error, _error} ->
        render_404_page(conn)
    end
  end

  defp check_api_response_for_404(conn, status) do
    if status != 200, do: render_404_page(conn)
  end

  defp render_404_page(conn) do 
    conn 
      |> put_view(NfdWeb.ErrorView)
      |> render("404.html")
  end

  defp getPreviousNextArticle(articles, currentArticle) do
    articleValues = 
      Enum.reduce(articles, %{last: nil, values: [], correct: false, previousArticle: nil, nextArticle: nil}, fn article, acc ->
        if acc.correct do
          %{last: article, previousArticle: acc.previousArticle, nextArticle: article, correct: false }
        else  
          if currentArticle["slug"] == article["slug"] do 
            %{last: article, previousArticle: acc.last, nextArticle: nil, correct: true }
          else 
            %{last: article, previousArticle: acc.previousArticle, nextArticle: acc.nextArticle, correct: false}
          end
        end
      end)
      
    { articleValues.previousArticle, articleValues.nextArticle }
  end
end
