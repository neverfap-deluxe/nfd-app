defmodule Nfd.Sitemaps do
  alias NfdWeb.Endpoint
  alias NfdWeb.Router.Helpers

  import Ecto.Query, warn: false

  alias Nfd.API
  alias Nfd.API.PageAPI
  # alias Nfd.API.ContentAPI

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
    # client = "http://localhost:1313" |> API.api_client()

    with {:ok, articlesResponse} <- (client |> PageAPI.articles()),
         {:ok, practicesResponse} <- (client |> PageAPI.practices()),
         {:ok, coursesResponse} <- (client |> PageAPI.courses()),
         {:ok, podcastsResponse} <- (client |> PageAPI.podcasts()),
         {:ok, quotesResponse} <- (client |> PageAPI.quotes()),
         {:ok, meditationsResponse} <- (client |> PageAPI.meditations()),
         {:ok, blogsResponse} <- (client |> PageAPI.blogs()),
         {:ok, updatesResponse} <- (client |> PageAPI.updates())

        #  {:ok, sdkResponse} <- (client |> PageAPI.seven_day_kickstarter()),
        #  {:ok, tdmResponse} <- (client |> PageAPI.ten_day_meditation()),
        #  {:ok, vol1Response} <- (client |> PageAPI.seven_week_awareness_vol_1()),
        #  {:ok, vol2Response} <- (client |> PageAPI.seven_week_awareness_vol_2()),
        #  {:ok, vol3Response} <- (client |> PageAPI.seven_week_awareness_vol_3()),
        #  {:ok, vol4Response} <- (client |> PageAPI.seven_week_awareness_vol_4())
    do
      create do
        # GENERAL
        add Helpers.page_path(Endpoint, :general_home), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.page_path(Endpoint, :general_about), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.page_path(Endpoint, :general_contact), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.page_path(Endpoint, :general_community), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.page_path(Endpoint, :general_donations), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.page_path(Endpoint, :general_everything), priority: 0.5, changefreq: "weekly", expires: nil
        # add Helpers.page_path(Endpoint, :general_premium), priority: 0.5, changefreq: "weekly", expires: nil

        # GUIDE
        add Helpers.page_path(Endpoint, :guides_guide), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.page_path(Endpoint, :guides_summary), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.page_path(Endpoint, :guides_neverfap_deluxe_bible), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.page_path(Endpoint, :guides_post_relapse_academy), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.page_path(Endpoint, :guides_emergency), priority: 0.5, changefreq: "weekly", expires: nil

        # PROGRAMS
        add Helpers.page_path(Endpoint, :programs_accountability), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.page_path(Endpoint, :programs_reddit_guidelines), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.page_path(Endpoint, :programs_coaching), priority: 0.5, changefreq: "weekly", expires: nil

        # VOLUNTEER
        add Helpers.page_path(Endpoint, :volunteer_helpful_neverfap_counsel), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.page_path(Endpoint, :volunteer_engineering_corps), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.page_path(Endpoint, :volunteer_marketing_department), priority: 0.5, changefreq: "weekly", expires: nil

        # APPS
        add Helpers.page_path(Endpoint, :apps_mobile_app), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.page_path(Endpoint, :apps_desktop_app), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.page_path(Endpoint, :apps_chrome_extension), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.page_path(Endpoint, :apps_neverfap_deluxe_league), priority: 0.5, changefreq: "weekly", expires: nil

        # LEGAL
        add Helpers.page_path(Endpoint, :legal_disclaimer), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.page_path(Endpoint, :legal_privacy), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.page_path(Endpoint, :legal_terms_and_conditions), priority: 0.5, changefreq: "weekly", expires: nil

        # MISC
        add Helpers.page_path(Endpoint, :misc_never_fap), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.page_path(Endpoint, :misc_teens), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.page_path(Endpoint, :misc_porn_addiction), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.page_path(Endpoint, :misc_porn_addiction_quiz), priority: 0.5, changefreq: "weekly", expires: nil

        # CONTENT
        add Helpers.content_path(Endpoint, :articles), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.content_path(Endpoint, :practices), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.content_path(Endpoint, :courses), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.content_path(Endpoint, :podcasts), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.content_path(Endpoint, :quotes), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.content_path(Endpoint, :meditations), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.content_path(Endpoint, :blogs), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.content_path(Endpoint, :updates), priority: 0.5, changefreq: "weekly", expires: nil

        # CONTENT SINGLE
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

        # CONTENT EMAIL
        add Helpers.content_email_path(Endpoint, :seven_day_kickstarter), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.content_email_path(Endpoint, :ten_day_meditation), priority: 0.5, changefreq: "weekly", expires: nil

        add Helpers.content_email_path(Endpoint, :seven_week_awareness_vol_1), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.content_email_path(Endpoint, :seven_week_awareness_vol_2), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.content_email_path(Endpoint, :seven_week_awareness_vol_3), priority: 0.5, changefreq: "weekly", expires: nil
        add Helpers.content_email_path(Endpoint, :seven_week_awareness_vol_4), priority: 0.5, changefreq: "weekly", expires: nil

        # add Helpers.content_email_path(Endpoint, :twenty_eight_day_awareness), priority: 0.5, changefreq: "weekly", expires: nil

        # CONTENT EMAIL SINGLE
        # Enum.each(sdkResponse.body["data"]["days"], fn(updateArg) ->
        #   add Helpers.content_email_path(Endpoint, :seven_day_kickstarter_single, updateArg["slug"]), priority: 0.5, changefreq: "weekly", expires: nil
        # end)

        # Enum.each(tdmResponse.body["data"]["days"], fn(updateArg) ->
        #   add Helpers.content_email_path(Endpoint, :ten_day_meditation_single, updateArg["slug"]), priority: 0.5, changefreq: "weekly", expires: nil
        # end)

        # Enum.each(vol1Response.body["data"]["days"], fn(updateArg) ->
        #   add Helpers.content_email_path(Endpoint, :seven_week_awareness_vol_1_single, updateArg["slug"]), priority: 0.5, changefreq: "weekly", expires: nil
        # end)

        # Enum.each(vol2Response.body["data"]["days"], fn(updateArg) ->
        #   add Helpers.content_email_path(Endpoint, :seven_week_awareness_vol_2_single, updateArg["slug"]), priority: 0.5, changefreq: "weekly", expires: nil
        # end)

        # Enum.each(vol3Response.body["data"]["days"], fn(updateArg) ->
        #   add Helpers.content_email_path(Endpoint, :seven_week_awareness_vol_3_single, updateArg["slug"]), priority: 0.5, changefreq: "weekly", expires: nil
        # end)

        # Enum.each(vol4Response.body["data"]["days"], fn(updateArg) ->
        #   add Helpers.content_email_path(Endpoint, :seven_week_awareness_vol_4_single, updateArg["slug"]), priority: 0.5, changefreq: "weekly", expires: nil
        # end)

      end
    end

    ping()
  end
end
