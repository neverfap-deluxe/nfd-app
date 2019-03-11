defmodule Nfd.Sitemaps do
  alias NfdWeb.Endpoint
  alias NfdWeb.Router.Helpers

  import Ecto.Query, warn: false
  alias Nfd.Repo

  alias NfdWeb.PageAPI

  # For testing: Nfd.Sitemaps.generate()

  use Sitemap,
      host: "https://neverfapdeluxe.com",
      files_path: "priv/static/",
      public_path: "/",
      compress: false

  # Generate

  def generate do
    client = "https://neverfapdeluxe.netlify.com" |> PageAPI.api_client()

    with {:ok, articlesResponse} <- (client |> PageAPI.articles()),
         {:ok, practicesResponse} <- (client |> PageAPI.practices()),
         {:ok, coursesResponse} <- (client |> PageAPI.courses()),
         {:ok, podcastsResponse} <- (client |> PageAPI.podcasts()),
         {:ok, quotesResponse} <- (client |> PageAPI.quotes())
    do 
      create do
        add Helpers.page_path(Endpoint, :home), priority: 0.5, changefreq: "daily", expires: nil
        add Helpers.page_path(Endpoint, :guide), priority: 0.5, changefreq: "daily", expires: nil
        add Helpers.page_path(Endpoint, :community), priority: 0.5, changefreq: "daily", expires: nil
        add Helpers.page_path(Endpoint, :about), priority: 0.5, changefreq: "daily", expires: nil
        add Helpers.page_path(Endpoint, :contact), priority: 0.5, changefreq: "daily", expires: nil
        add Helpers.page_path(Endpoint, :disclaimer), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.page_path(Endpoint, :privacy), priority: 0.5, changefreq: "weekly", expires: nil

        add Helpers.page_path(Endpoint, :articles), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.page_path(Endpoint, :practices), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.page_path(Endpoint, :courses), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.page_path(Endpoint, :podcasts), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.page_path(Endpoint, :quotes), priority: 0.5, changefreq: "weekly", expires: nil

        Enum.each(articlesResponse.body["data"]["articles"], fn(article) ->
          add Helpers.page_path(Endpoint, :article, article["slug"]), priority: 0.5, changefreq: "daily", expires: nil                    
        end)

        Enum.each(practicesResponse.body["data"]["practices"], fn(practice) ->
          add Helpers.page_path(Endpoint, :practice, practice["slug"]), priority: 0.5, changefreq: "daily", expires: nil                    
        end)

        Enum.each(coursesResponse.body["data"]["courses"], fn(course) ->
          add Helpers.page_path(Endpoint, :course, course["slug"]), priority: 0.5, changefreq: "daily", expires: nil                    
        end)

        Enum.each(podcastsResponse.body["data"]["podcasts"], fn(podcast) ->
          add Helpers.page_path(Endpoint, :podcast, podcast["slug"]), priority: 0.5, changefreq: "daily", expires: nil                    
        end)

        Enum.each(quotesResponse.body["data"]["quotes"], fn(quoteArg) ->
          add Helpers.page_path(Endpoint, :quote, quoteArg["slug"]), priority: 0.5, changefreq: "daily", expires: nil                    
        end)

        # TODO: Will also need to configure the individual days, once they're created.
        add Helpers.page_path(Endpoint, :seven_day_kickstarter), priority: 0.5, changefreq: "daily", expires: nil
        add Helpers.page_path(Endpoint, :ten_day_meditation), priority: 0.5, changefreq: "daily", expires: nil
        add Helpers.page_path(Endpoint, :twenty_eight_day_awareness), priority: 0.5, changefreq: "daily", expires: nil        

      end
    end
    ping()
  end 
end
