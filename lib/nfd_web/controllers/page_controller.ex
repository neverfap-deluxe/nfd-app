defmodule NfdWeb.PageController do
  use NfdWeb, :controller

  alias NfdWeb.PageJson

  plug :put_layout, "general.html"

  def home(conn, _params) do
    {:ok, response} = PageJson.home()

    IO.inspect(response)
    render(conn, "home.html", item: response.body["data"])
  end

  def about(conn, _params) do
    {:ok, response} = PageJson.about()

    render(conn, "about.html", item: response.body["data"])
  end

  def contact(conn, _params) do
    {:ok, response} = PageJson.contact()
    render(conn, "contact.html", item: response.body["data"])
  end


  # Content

  def articles(conn, %{"name" => name}) do
    {:ok, response} = PageJson.articles(name)
    render(conn, "articles.html", item: response.body["data"])
  end

  def article(conn, _params) do
    {:ok, response} = PageJson.article()
    render(conn, "article.html", item: response.body["data"])
  end

  def practices(conn, %{"name" => name}) do
    {:ok, response} = PageJson.practices(name)
    render(conn, "practices.html", item: response.body["data"])
  end

  def practice(conn, _params) do
    {:ok, response} = PageJson.practice()
    render(conn, "practice.html", item: response.body["data"])
  end

  def courses(conn, _params) do
    {:ok, response} = PageJson.courses()
    render(conn, "courses.html", item: response.body["data"])
  end

  def course(conn, %{"name" => name}) do
    {:ok, response} = PageJson.course(name)
    render(conn, "course.html", item: response.body["data"])
  end

  def podcasts(conn, _params) do
    {:ok, response} = PageJson.podcasts()
    render(conn, "podcasts.html", item: response.body["data"])
  end

  def podcast(conn, _params) do
    {:ok, response} = PageJson.podcast()
    render(conn, "podcast.html", item: response.body["data"])
  end

  def disclaimer(conn, _params) do
    {:ok, response} = PageJson.disclaimer()
    render(conn, "disclaimer.html", item: response.body["data"])
  end

  def privacy(conn, _params) do
    {:ok, response} = PageJson.privacy()
    render(conn, "privacy.html", item: response.body["data"])
  end


end
