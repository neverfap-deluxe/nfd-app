defmodule Nfd.API.Content do
  use Tesla

  def article(client, article_name), do: get(client, "/articles/" <> article_name <> "/index.json")
  def practice(client, practice_name), do: get(client, "/practices/" <> practice_name <> "/index.json")
  def course(client, course_name), do: get(client, "/courses/" <> course_name <> "/index.json")
  def podcast(client, podcast_name), do: get(client, "/podcast/" <> podcast_name <> "/index.json")
  def quote(client, quote_name), do: get(client, "/quotes/" <> quote_name <> "/index.json")
  def meditation(client, meditation_name), do: get(client, "/meditations/" <> meditation_name <> "/index.json")
  def blog(client, blog_name), do: get(client, "/blogs/" <> blog_name <> "/index.json")
  def update(client, update_name), do: get(client, "/updates/" <> update_name <> "/index.json")

  def seven_day_kickstarter_single(client, slug), do: get(client, "/seven_day_kickstarter/" <> slug <> "/index.json")
  def ten_day_meditation_single(client, slug), do: get(client, "/ten_day_meditation/" <> slug <> "/index.json")
  def twenty_eight_day_awareness_single(client, slug), do: get(client, "/twenty_eight_day_awareness/" <> slug <> "/index.json")
end