defmodule Nfd.API.Page do
  use Tesla

  # GENERAL
  def home(client), do: get(client, "/general_home/index.json")
  def community(client), do: get(client, "/general_community/index.json")
  def about(client), do: get(client, "/general_about/index.json")
  def contact(client), do: get(client, "/general_contact/index.json")
  def donations(client), do: get(client, "/general_donations/index.json")
  def everything(client), do: get(client, "/general_everything/index.json")

  # GUIDE
  def guide(client), do: get(client, "/guides_guide/index.json")
  def summary(client), do: get(client, "/guides_summary/index.json")
  def neverfap_deluxe_bible(client), do: get(client, "/guides_neverfap_deluxe_bible/index.json")
  def post_relapse_academy(client), do: get(client, "/guides_post_relapse_academy/index.json")
  def emergency(client), do: get(client, "/guides_emergency/index.json")

  # PROGRAMS
  def accountability(client), do: get(client, "/programs_accountability/index.json")
  def reddit_guidelines(client), do: get(client, "/programs_reddit_guidelines/index.json")
  def coaching(client), do: get(client, "/programs_coaching/index.json")

  # VOLUNTEER
  def helpful_neverfap_counsel(client), do: get(client, "/volunteer_helpful_neverfap_counsel/index.json")
  def engineering_corps(client), do: get(client, "/volunteer_engineering_corps/index.json")
  def marketing_department(client), do: get(client, "/volunteer_marketing_department/index.json")

  # APPS
  def desktop_app(client), do: get(client, "/apps_desktop_app/index.json")
  def mobile_app(client), do: get(client, "/apps_mobile_app/index.json")
  def chrome_extension(client), do: get(client, "/apps_chrome_extension/index.json")
  def neverfap_deluxe_league(client), do: get(client, "/apps_neverfap_deluxe_league/index.json")
  def open_source(client), do: get(client, "/apps_open_source/index.json")

  # MISC
  def never_fap(client), do: get(client, "/misc_never_fap/index.json")

  # LEGAL
  def disclaimer(client), do: get(client, "/legal_disclaimer/index.json")
  def privacy(client), do: get(client, "/legal_privacy/index.json")
  def terms_and_conditions(client), do: get(client, "/legal_terms_and_conditions/index.json")

  # CONTENT PAGES
  def articles(client), do: get(client, "/content_articles/index.json")
  def practices(client), do: get(client, "/content_practices/index.json")
  def courses(client), do: get(client, "/content_courses/index.json")
  def podcasts(client), do: get(client, "/content_podcast/index.json")
  def quotes(client), do: get(client, "/content_quotes/index.json")
  def meditations(client), do: get(client, "/content_meditations/index.json")
  def blogs(client), do: get(client, "/content_blogs/index.json")
  def updates(client), do: get(client, "/content_updates/index.json")

  # CONTENT EMAIL PAGES
  def seven_day_kickstarter(client), do: get(client, "/email_seven_day_kickstarter/index.json")
  def ten_day_meditation(client), do: get(client, "/email_ten_day_meditation/index.json")
  def twenty_eight_day_awareness(client), do: get(client, "/email_twenty_eight_day_awareness/index.json")
end
