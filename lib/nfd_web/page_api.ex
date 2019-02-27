defmodule NfdWeb.PageAPI do
  use Tesla

  # plug Tesla.Middleware.BaseUrl, "https://netlify.neverfapdeluxe.com"
  plug Tesla.Middleware.BaseUrl, "http://localhost:1313"
  plug Tesla.Middleware.JSON

  # Single Page Data

  def home() do
    get("/index.json")
  end

  def article(article_name) do
    get("/articles/" <> article_name <> "/index.json")
  end

  def articles() do
    get("/articles/articles_page/index.json")
  end

  def practice(practice_name) do
    get("/practices/" <> practice_name <> "/index.json")
  end

  def practices() do
    get("/practices/practices_page/index.json")
  end

  def course(course_name) do
    get("/courses/" <> course_name <> "/index.json")
  end

  def courses() do
    get("/courses/courses_page/index.json")
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



  # list content

  def articles_content() do
    get("/articles/index.json")
  end

  def practices_content() do
    get("/practices/index.json")
  end

  def courses_content() do
    get("/courses/index.json")
  end

end
