defmodule NfdWeb.PageController do
  use NfdWeb, :controller

  plug :put_layout, "general.html"

  def home(conn, _params) do
    
    render(conn, "home.html")
  end

  def about(conn, _params) do
    render(conn, "about.html")
  end

  def contact(conn, _params) do
    render(conn, "contact.html")
  end

  def articles(conn, _params) do
    render(conn, "articles.html")
  end

  def article(conn, _params) do
    render(conn, "article.html")
  end

  def practices(conn, _params) do
    render(conn, "practices.html")
  end

  def practice(conn, _params) do
    render(conn, "practice.html")
  end

  def courses(conn, _params) do
    render(conn, "courses.html")
  end

  def course(conn, _params) do
    render(conn, "course.html")
  end

  def podcasts(conn, _params) do
    render(conn, "podcasts.html")
  end

  def podcast(conn, _params) do
    render(conn, "podcast.html")
  end

  def disclaimer(conn, _params) do
    render(conn, "disclaimer.html")
  end

  def privacy(conn, _params) do
    render(conn, "privacy.html")
  end


end
