defmodule NfdWeb.PageAPI do
  use Tesla

  def is_localhost(host) do
    if host == "localhost" do 
      "http://localhost:1313"
    else 
      "https://neverfapdeluxe.netlify.com"      
    end
  end

  def api_client(api_endpoint) do
    middleware = [
      {Tesla.Middleware.BaseUrl, api_endpoint},
      Tesla.Middleware.JSON,
    ]

    Tesla.client(middleware)
  end

  # Single Page Data

  def article(client, article_name) do
    get(client, "/articles/" <> article_name <> "/index.json")
  end

  def articles(client) do
    get(client, "/articles/index.json")
  end

  def practice(client, practice_name) do
    get(client, "/practices/" <> practice_name <> "/index.json")
  end

  def practices(client) do
    get(client, "/practices/index.json")
  end

  def course(client, course_name) do
    get(client, "/courses/" <> course_name <> "/index.json")
  end

  def courses(client) do
    get(client, "/courses/index.json")
  end

  def podcast(client, podcast_name) do
    get(client, "/podcast/" <> podcast_name <> "/index.json")
  end

  def podcasts(client) do
    get(client, "/podcast/index.json")
  end

  def quote(client, quote_name) do
    get(client, "/quotes/" <> quote_name <> "/index.json")
  end

  def quotes(client) do
    get(client, "/quotes/index.json")
  end


  # Pages

  def home(client) do
    get(client, "/index.json")
  end

  def guide(client) do
    get(client, "/guide/index.json")
  end

  def about(client) do
    get(client, "/about/index.json")
  end

  def contact(client) do
    get(client, "/contact/index.json")
  end

  def disclaimer(client) do
    get(client, "/disclaimer/index.json")
  end

  def privacy(client) do
    get(client, "/privacy/index.json")
  end

  # Special

  def account(client) do
    get(client, "/account/index.json")
  end

  def seven_day_kickstarter(client) do
    get(client, "/seven_day_kickstarter/index.json")
  end

end
