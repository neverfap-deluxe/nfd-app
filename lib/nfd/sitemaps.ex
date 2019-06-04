defmodule Nfd.Sitemaps do
  alias NfdWeb.Endpoint
  alias NfdWeb.Router.Helpers

  import Ecto.Query, warn: false

  alias Nfd.API
  alias Nfd.API.Content
  alias Nfd.API.ContentEmail

  # For testing: Nfd.Sitemaps.generate()
  # iex -S mix do phx.server
  # iex -S mix do ecto.setup, phx.server

  use Sitemap,
      host: "https://neverfapdeluxe.com",
      files_path: "priv/static/sitemaps/",
      public_path: "sitemaps/",
      verbose: true,
      compress: false

  # Generate
  def generate do
    client = "https://neverfapdeluxe.netlify.com" |> API.api_client()

    with {:ok, articlesResponse} <- (client |> Content.articles()),
         {:ok, practicesResponse} <- (client |> Content.practices()),
         {:ok, coursesResponse} <- (client |> Content.courses()),
         {:ok, podcastsResponse} <- (client |> Content.podcasts()),
         {:ok, quotesResponse} <- (client |> Content.quotes()),
         {:ok, meditationsResponse} <- (client |> Content.meditations()),
         {:ok, blogsResponse} <- (client |> Content.blogs()),
         {:ok, updatesResponse} <- (client |> Content.updates()),
         {:ok, sdkResponse} <- (client |> ContentEmail.seven_day_kickstarter())
    do
      create do
        add Helpers.page_path(Endpoint, :home), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.page_path(Endpoint, :guide), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.page_path(Endpoint, :community), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.page_path(Endpoint, :about), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.page_path(Endpoint, :contact), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.page_path(Endpoint, :disclaimer), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.page_path(Endpoint, :privacy), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.page_path(Endpoint, :terms_and_conditions), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.page_path(Endpoint, :accountability), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.page_path(Endpoint, :reddit_guidelines), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.page_path(Endpoint, :everything), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.page_path(Endpoint, :coaching), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.page_path(Endpoint, :post_relapse_academy), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.page_path(Endpoint, :emergency), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.page_path(Endpoint, :neverfap_deluxe_league), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.page_path(Endpoint, :neverfap_deluxe_bible), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.page_path(Endpoint, :helpful_neverfappers_academy), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.page_path(Endpoint, :summary), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.page_path(Endpoint, :donations), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.page_path(Endpoint, :promote_neverfap_deluxe), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.page_path(Endpoint, :never_fap), priority: 0.5, changefreq: "weekly", expires: nil

        add Helpers.page_path(Endpoint, :mobile_app), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.page_path(Endpoint, :desktop_app), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.page_path(Endpoint, :chrome_extension), priority: 0.5, changefreq: "weekly", expires: nil

        add Helpers.content_path(Endpoint, :articles), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.content_path(Endpoint, :practices), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.content_path(Endpoint, :courses), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.content_path(Endpoint, :podcasts), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.content_path(Endpoint, :quotes), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.content_path(Endpoint, :meditations), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.content_path(Endpoint, :blogs), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.content_path(Endpoint, :updates), priority: 0.5, changefreq: "weekly", expires: nil

        Enum.each(articlesResponse.body["data"]["articles"], fn(article) ->
          add Helpers.content_path(Endpoint, :article, article["slug"]), priority: 0.5, changefreq: "weekly", expires: nil
        end)

        Enum.each(practicesResponse.body["data"]["practices"], fn(practice) ->
          add Helpers.content_path(Endpoint, :practice, practice["slug"]), priority: 0.5, changefreq: "weekly", expires: nil
        end)

        Enum.each(coursesResponse.body["data"]["courses"], fn(course) ->
          add Helpers.content_path(Endpoint, :course, course["slug"]), priority: 0.5, changefreq: "weekly", expires: nil
        end)

        Enum.each(podcastsResponse.body["data"]["podcasts"], fn(podcast) ->
          add Helpers.content_path(Endpoint, :podcast, podcast["slug"]), priority: 0.5, changefreq: "weekly", expires: nil
        end)

        Enum.each(quotesResponse.body["data"]["quotes"], fn(quoteArg) ->
          add Helpers.content_path(Endpoint, :quote, quoteArg["slug"]), priority: 0.5, changefreq: "weekly", expires: nil
        end)

        Enum.each(meditationsResponse.body["data"]["meditations"], fn(meditationArg) ->
          add Helpers.content_path(Endpoint, :meditation, meditationArg["slug"]), priority: 0.5, changefreq: "weekly", expires: nil
        end)

        Enum.each(blogsResponse.body["data"]["blogs"], fn(blogArg) ->
          add Helpers.content_path(Endpoint, :blog, blogArg["slug"]), priority: 0.5, changefreq: "weekly", expires: nil
        end)

        Enum.each(updatesResponse.body["data"]["updates"], fn(updateArg) ->
          add Helpers.content_path(Endpoint, :update, updateArg["slug"]), priority: 0.5, changefreq: "weekly", expires: nil
        end)

        Enum.each(sdkResponse.body["data"]["days"], fn(updateArg) ->
          add Helpers.content_email_path(Endpoint, :seven_day_kickstarter_single, updateArg["slug"]), priority: 0.5, changefreq: "weekly", expires: nil
        end)

        # TODO: Will also need to configure the individual days, once they're created.
        add Helpers.content_email_path(Endpoint, :seven_day_kickstarter), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.content_email_path(Endpoint, :ten_day_meditation), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.content_email_path(Endpoint, :twenty_eight_day_awareness), priority: 0.5, changefreq: "weekly", expires: nil
      end
    end

    ping()
  end
end
