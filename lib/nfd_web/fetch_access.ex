defmodule NfdWeb.FetchAccess do
  defp apmss do
    [:articles, :practices, :meditations, :seven_day_kickstarter, :seven_day_kickstarter_changeset]
  end

  defp ccp do
    [:comments, :comment_form_changeset, :previous_next]
  end

  def fetch_access_array(name) do
    case name do
      # PAGE CONTROLLERS
      # GENERAL
      :general_home -> apmss ++ []
      :general_about -> apmss ++ [:contact_form_changeset]
      :general_contact -> apmss ++ [:contact_form_changeset]
      :general_community -> apmss ++ []
      :general_donations -> []
      :general_everything -> []
      :general_premium -> []

      # GUIDES
      :guides_guide -> apmss ++ []
      :guides_summary -> apmss ++ []
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
      :programs_coaching -> [:contact_form_changeset]

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
      :misc_teens -> []
      :misc_porn_addiction -> []

      # CONTENT
      :articles -> apmss ++ []
      :article -> apmss ++ ccp ++ [:article]

      :practices -> apmss ++ []
      :practice -> apmss ++ ccp ++ [:practice]

      :meditations -> apmss ++ []
      :meditation -> apmss ++ ccp ++ [:meditation]

      :courses -> [:courses]
      :course -> apmss ++ [:course]

      :podcasts -> apmss ++ [:podcasts]
      :podcast -> apmss ++ ccp ++ [:podcasts, :podcast]

      :quotes -> apmss ++ [:quotes]
      :quote -> apmss ++ ccp ++ [:quotes, :quote]

      :blogs -> [:blogs]
      :blog -> apmss ++ ccp ++ [:blogs, :blog]

      :updates -> [:updates]
      :update -> apmss ++ ccp ++ [:updates, :update]

      # CONTENT EMAIL
      :seven_day_kickstarter ->  [:seven_day_kickstarter, :seven_day_kickstarter_changeset]
      :seven_day_kickstarter_single -> [:seven_day_kickstarter_single, :course]

      :ten_day_meditation -> [:ten_day_meditation]
      :ten_day_meditation_single -> [:ten_day_meditation_single, :course]

      :twenty_eight_day_awareness -> [:twenty_eight_day_awareness, :twenty_eight_day_awareness_changeset]
      :twenty_eight_day_awareness_single -> [:twenty_eight_day_awareness_single, :course]

      :seven_week_awareness_vol_1 -> [:seven_week_awareness_vol_1, :seven_week_awareness_vol_1_changeset]
      :seven_week_awareness_vol_1_single -> [:seven_week_awareness_vol_1_single, :course]

      :seven_week_awareness_vol_2 -> [:seven_week_awareness_vol_2, :seven_week_awareness_vol_2_changeset]
      :seven_week_awareness_vol_2_single -> [:seven_week_awareness_vol_2_single, :course]

      :seven_week_awareness_vol_3 -> [:seven_week_awareness_vol_3, :seven_week_awareness_vol_3_changeset]
      :seven_week_awareness_vol_3_single -> [:seven_week_awareness_vol_3_single, :course]

      :seven_week_awareness_vol_4 -> [:seven_week_awareness_vol_4, :seven_week_awareness_vol_4_changeset]
      :seven_week_awareness_vol_4_single -> [:seven_week_awareness_vol_4_single, :course]

      # DASHBOARD
      :dashboard -> [:courses, :ebooks, :purchased_ebooks, :purchased_courses, :not_purchased_ebooks, :not_purchased_courses, :patreon_auth_url]
      :dashboard_coaching -> [:stripe_session, :stripe_api_key, :paypal_api_key]
      :dashboard_faq -> []

      :dashboard_courses -> [:courses]
      :dashboard_course_collection -> [:courses, :course, :subscription_emails, :subscribed_property, :stripe_session, :paypal_session, :stripe_api_key, :paypal_api_key]
      :dashboard_course_file -> [:courses, :course, :course_file]

      :dashboard_ebooks -> [:ebooks]
      :dashboard_ebook_collection -> [:ebooks, :ebook, :stripe_session, :paypal_session, :stripe_api_key, :paypal_api_key]
      :dashboard_ebook_file -> [:ebooks, :ebook, :ebook_file]

      :dashboard_profile -> []
      :dashboard_profile_delete_confirmation -> []
    end
  end
end
