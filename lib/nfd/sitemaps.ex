defmodule Nfd.Sitemaps do
  alias NfdWeb.Endpoint
  alias NfdWeb.Router.Helpers

  import Ecto.Query, warn: false
  alias Nfd.Repo

  alias NfdWeb.PageAPI

  use Sitemap,
      host: "https://neverfapdeluxe.com",
      files_path: "priv/static/",
      public_path: "/",
      compress: false

  # Generate

  def generate do

    articles = PageAPI.articles()
    practices = PageAPI.practices()
    courses = PageAPI.courses()
    podcasts = PageAPI.podcasts()
    quotes = PageAPI.quotes()
    
    create do
      add Helpers.page_path(Endpoint, :home), priority: 0.5, changefreq: "daily", expires: nil
      add Helpers.page_path(Endpoint, :about), priority: 0.5, changefreq: "daily", expires: nil
      add Helpers.page_path(Endpoint, :contact), priority: 0.5, changefreq: "daily", expires: nil

      add Helpers.page_path(Endpoint, :guide), priority: 0.5, changefreq: "daily", expires: nil
      add Helpers.page_path(Endpoint, :seven_day_kickstarter), priority: 0.5, changefreq: "daily", expires: nil
      add Helpers.page_path(Endpoint, :ten_day_meditation), priority: 0.5, changefreq: "daily", expires: nil
      add Helpers.page_path(Endpoint, :twenty_eight_day_awareness), priority: 0.5, changefreq: "daily", expires: nil
      
      add Helpers.page_path(Endpoint, :disclaimer), priority: 0.5, changefreq: "weekly", expires: nil
      add Helpers.page_path(Endpoint, :privacy), priority: 0.5, changefreq: "weekly", expires: nil
      add Helpers.page_path(Endpoint, :account), priority: 0.5, changefreq: "weekly", expires: nil

      add Helpers.page_path(Endpoint, :articles), priority: 0.5, changefreq: "weekly", expires: nil
      add Helpers.page_path(Endpoint, :practices), priority: 0.5, changefreq: "weekly", expires: nil
      add Helpers.page_path(Endpoint, :courses), priority: 0.5, changefreq: "weekly", expires: nil
      add Helpers.page_path(Endpoint, :podcasts), priority: 0.5, changefreq: "weekly", expires: nil
      add Helpers.page_path(Endpoint, :quotes), priority: 0.5, changefreq: "weekly", expires: nil

      Enum.each(articles, fn(article) ->
        add Helpers.page_path(Endpoint, :article, article.slug), priority: 0.5, changefreq: "daily", expires: nil                    
      end)

      Enum.each(practices, fn(practice) ->
        add Helpers.page_path(Endpoint, :practice, practice.slug), priority: 0.5, changefreq: "daily", expires: nil                    
      end)

      Enum.each(courses, fn(course) ->
        add Helpers.page_path(Endpoint, :course, course.slug), priority: 0.5, changefreq: "daily", expires: nil                    
      end)

      Enum.each(podcasts, fn(podcast) ->
        add Helpers.page_path(Endpoint, :podcast, podcast.slug), priority: 0.5, changefreq: "daily", expires: nil                    
      end)

      Enum.each(quotes, fn(quoteArg) ->
        add Helpers.page_path(Endpoint, :quote, quoteArg.slug), priority: 0.5, changefreq: "daily", expires: nil                    
      end)

    end
    
    ping()

  end
end
