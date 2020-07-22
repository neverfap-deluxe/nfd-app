defmodule Nfd.API.PageAPI do
  use Tesla

  # GENERAL
  def general_home(client), do: get(client, "/general_home/index.json")
  def general_community(client), do: get(client, "/general_community/index.json")
  def general_about(client), do: get(client, "/general_about/index.json")
  def general_contact(client), do: get(client, "/general_contact/index.json")
  def general_donations(client), do: get(client, "/general_donations/index.json")
  def general_everything(client), do: get(client, "/general_everything/index.json")
  def general_premium(client), do: get(client, "/general_premium/index.json")
  # GENERAL END

  # GUIDES
  def guides_guide(client), do: get(client, "/guides_guide/index.json")
  def guides_summary(client), do: get(client, "/guides_summary/index.json")
  def guides_neverfap_deluxe_bible(client), do: get(client, "/guides_neverfap_deluxe_bible/index.json")
  def guides_post_relapse_academy(client), do: get(client, "/guides_post_relapse_academy/index.json")
  def guides_emergency(client), do: get(client, "/guides_emergency/index.json")
  def guides_complete_understanding(client), do: get(client, "/guides_complete_understanding/index.json")
  def guides_curriculum(client), do: get(client, "/guides_curriculum/index.json")
  # def guides_fundamental_meditation_series(client), do: get(client, "/guides_fundamental_meditation_series/index.json")
  # GUIDES END

  # PROGRAMS
  def programs_accountability(client), do: get(client, "/programs_accountability/index.json")
  def programs_reddit_guidelines(client), do: get(client, "/programs_reddit_guidelines/index.json")
  def programs_coaching(client), do: get(client, "/programs_coaching/index.json")
  # PROGRAMS END

  # VOLUNTEER
  def volunteer_helpful_neverfap_counsel(client), do: get(client, "/volunteer_helpful_neverfap_counsel/index.json")
  def volunteer_engineering_corps(client), do: get(client, "/volunteer_engineering_corps/index.json")
  def volunteer_marketing_department(client), do: get(client, "/volunteer_marketing_department/index.json")
  # VOLUNTEER END

  # APPS
  def apps_desktop_app(client), do: get(client, "/apps_desktop_app/index.json")
  def apps_mobile_app(client), do: get(client, "/apps_mobile_app/index.json")
  def apps_chrome_extension(client), do: get(client, "/apps_chrome_extension/index.json")
  def apps_neverfap_deluxe_league(client), do: get(client, "/apps_neverfap_deluxe_league/index.json")
  def apps_open_source(client), do: get(client, "/apps_open_source/index.json")
  def apps_hovering(client), do: get(client, "/apps_hovering/index.json")
  # APPS END

  # MISC
  def misc_never_fap(client), do: get(client, "/misc_never_fap/index.json")
  def misc_teens(client), do: get(client, "/misc_teens/index.json")
  def misc_porn_addiction(client), do: get(client, "/misc_porn_addiction/index.json")
  def misc_porn_addiction_quiz(client), do: get(client, "/misc_porn_addiction_quiz/index.json")
  # MISC END

  # LEGAL
  def legal_disclaimer(client), do: get(client, "/legal_disclaimer/index.json")
  def legal_privacy(client), do: get(client, "/legal_privacy/index.json")
  def legal_terms_and_conditions(client), do: get(client, "/legal_terms_and_conditions/index.json")
  # LEGAL END

  # CONTENT PAGES
  def articles(client), do: get(client, "/content_articles/index.json")
  def practices(client), do: get(client, "/content_practices/index.json")
  def courses(client), do: get(client, "/content_courses/index.json")
  def podcasts(client), do: get(client, "/content_podcast/index.json")
  def quotes(client), do: get(client, "/content_quotes/index.json")
  def meditations(client), do: get(client, "/content_meditations/index.json")
  def blogs(client), do: get(client, "/content_blogs/index.json")
  def updates(client), do: get(client, "/content_updates/index.json")
  # CONTENT PAGES END

  # CONTENT EMAIL PAGES
  def seven_day_kickstarter(client), do: get(client, "/email_seven_day_kickstarter/index.json")
  def ten_day_meditation(client), do: get(client, "/email_ten_day_meditation/index.json")
  def twenty_eight_day_awareness(client), do: get(client, "/email_twenty_eight_day_awareness/index.json")

  def seven_week_awareness_vol_1(client), do: get(client, "/email_seven_week_awareness_vol_1/index.json")
  def seven_week_awareness_vol_2(client), do: get(client, "/email_seven_week_awareness_vol_2/index.json")
  def seven_week_awareness_vol_3(client), do: get(client, "/email_seven_week_awareness_vol_3/index.json")
  def seven_week_awareness_vol_4(client), do: get(client, "/email_seven_week_awareness_vol_4/index.json")
  # CONTENT EMAIL PAGES END

end
