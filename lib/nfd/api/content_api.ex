defmodule Nfd.API.Content do
  use Tesla

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

end
