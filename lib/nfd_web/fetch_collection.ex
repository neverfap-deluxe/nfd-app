defmodule NfdWeb.FetchCollection do
  def fetch_collections_array(name) do
    case name do
      # PAGE CONTROLLERS
      # GENERAL
      :general_home -> [:articles, :seven_day_kickstarter, :seven_day_kickstarter_changeset]
      :general_about -> [:contact_form_changeset]
      :general_contact -> []
      :general_community -> []
      :general_donations -> []
      :general_everything -> []
      :general_premium -> []

      # GUIDES
      :guides_guide -> [:articles, :seven_day_kickstarter, :seven_day_kickstarter_changeset]
      :guides_summary -> []
      :guides_neverfap_deluxe_bible -> []
      :guides_emergency -> []
      :guides_post_relapse_academy -> []

      # LEGAL
      :legal_disclaimer -> []
      :legal_privacy -> []
      :legal_terms_and_conditions -> []

      # PROGRAMS
      :programs_accountability -> []
      :programs_reddit_guidelines -> []
      :programs_coaching -> []

      # VOLUNTEER
      :volunteer_helpful_neverfap_counsel -> []
      :volunteer_engineering_corps -> []
      :volunteer_marketing_department -> []

      # APPS
      :apps_desktop_app -> []
      :apps_mobile_app -> []
      :apps_chrome_extension -> []
      :apps_open_source -> []
      :apps_neverfap_deluxe_league -> []

      # MISC
      :misc_never_fap -> []

      # CONTENT
      :articles -> [:articles]
      :article -> [:articles, :seven_day_kickstarter, :seven_day_kickstarter_changeset, :comments, :comment_form_changeset]

      :practices -> [:practices]
      :practice -> [:articles, :practices, :seven_day_kickstarter, :seven_day_kickstarter_changeset, :comments, :comment_form_changeset]

      :courses -> [:courses]
      :course -> [:articles, :practices]

      :podcasts -> [:podcasts]
      :podcast -> [:podcasts]

      :quotes -> [:quotes]
      :quote -> [:quotes]

      :meditations -> [:meditations]
      :meditation -> [:meditations]

      :blogs -> [:blogs]
      :blog -> [:blogs]

      :updates -> [:updates]
      :update -> [:updates]

      # CONTENT EMAIL
      :seven_day_kickstarter ->  [:seven_day_kickstarter, :seven_day_kickstarter_changeset]
      :seven_day_kickstarter_single -> [:seven_day_kickstarter]

      :ten_day_meditation ->  [:ten_day_meditation]
      :ten_day_meditation_single -> [:ten_day_meditation]

      :twenty_eight_day_awareness ->  [:twenty_eight_day_awareness, :twenty_eight_day_awareness_changeset]
      :twenty_eight_day_awareness_single -> [:twenty_eight_day_awareness]

      # DASHBOARD
      :dashboard -> [:collections_email]
      :dashboard_coaching -> [:collections_email]

      :email_campaigns -> [:collections_email]
      :email_campaigns_collection -> [:collection_email, :collections_email, :stripe_api_key]
      :email_campaigns_file -> [:collection_email, :collections_email, :collections_email_file, :stripe_api_key]

      :audio_courses -> [:collections_audio]
      :audio_courses_collection -> [:collection_audio, :collections_audio, :stripe_api_key]
      :audio_courses_file -> [:collection_audio, :collections_audio, :collections_audio_file, :stripe_api_key]

      :profile -> []
      :profile_delete_confirmation -> []
    end
  end

end
