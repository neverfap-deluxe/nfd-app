defmodule Nfd.API.Content do
  use Tesla

  def article(client, article_name), do: get(client, "/content_articles/" <> article_name <> "/index.json")
  def practice(client, practice_name), do: get(client, "/content_practices/" <> practice_name <> "/index.json")
  def course(client, course_name), do: get(client, "/content_courses/" <> course_name <> "/index.json")
  def podcast(client, podcast_name), do: get(client, "/content_podcast/" <> podcast_name <> "/index.json")
  def quote(client, quote_name), do: get(client, "/content_quotes/" <> quote_name <> "/index.json")
  def meditation(client, meditation_name), do: get(client, "/content_meditations/" <> meditation_name <> "/index.json")
  def blog(client, blog_name), do: get(client, "/content_blogs/" <> blog_name <> "/index.json")
  def update(client, update_name), do: get(client, "/content_updates/" <> update_name <> "/index.json")

  def seven_day_kickstarter_single(client, slug), do: get(client, "/email_seven_day_kickstarter/" <> slug <> "/index.json")
  def ten_day_meditation_single(client, slug), do: get(client, "/email_ten_day_meditation/" <> slug <> "/index.json")
  def twenty_eight_day_awareness_single(client, slug), do: get(client, "/email_twenty_eight_day_awareness/" <> slug <> "/index.json")
end