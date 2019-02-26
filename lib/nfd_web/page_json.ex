defmodule PageJson do
  use Tesla

  # plug Tesla.Middleware.BaseUrl, "https://netlify.neverfapdeluxe.com"
  plug Tesla.Middleware.BaseUrl, "http://localhost:1313"
  plug Tesla.Middleware.JSON

  def home() do
    get("/")
  end

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


  def about() do
    get("/about/index.json")
  end

  def contact() do
    get("/contact/index.json")
  end

  def disclaimer() do
    get("/courses/index.json")
  end

  def privacy() do
    get("/courses/index.json")
  end


end
