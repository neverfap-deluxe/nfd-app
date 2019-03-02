defmodule NfdWeb.PageAPI do
  use Tesla

  if Mix.env == :dev do 
    plug Tesla.Middleware.BaseUrl, "http://localhost:1313"
  else 
    plug Tesla.Middleware.BaseUrl, "https://netlify.neverfapdeluxe.com"
  end
  plug Tesla.Middleware.JSON

  # Single Page Data

  def article(article_name) do
    get("/articles/" <> article_name <> "/index.json")
  end

  def articles() do
    get("/articles/index.json")
  end

  def practice(practice_name) do
    get("/practices/" <> practice_name <> "/index.json")
  end

  def practices() do
    get("/practices/index.json")
  end

  def course(course_name) do
    get("/courses/" <> course_name <> "/index.json")
  end

  def courses() do
    get("/courses/index.json")
  end

  def podcast(podcast_name) do
    get("/podcasts/" <> podcast_name <> "/index.json")
  end

  def podcasts() do
    get("/podcasts/index.json")
  end


  # Pages

  def home() do
    get("/index.json")
  end

  def guide() do
    get("/guide/index.json")
  end

  def about() do
    get("/about/index.json")
  end

  def contact() do
    get("/contact/index.json")
  end

  def disclaimer() do
    get("/disclaimer/index.json")
  end

  def privacy() do
    get("/privacy/index.json")
  end

  def account() do
    get("/account/index.json")
  end
end
