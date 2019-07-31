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
      :general_donations -> [:meditations]
      :general_everything -> [:meditations]
      :general_premium -> [:meditations]

      # GUIDES
      :guides_guide -> apmss ++ []
      :guides_summary -> apmss ++ []
      :guides_neverfap_deluxe_bible -> [:meditations]
      :guides_emergency -> [:meditations]
      :guides_post_relapse_academy -> [:meditations]

      # LEGAL
      :legal_disclaimer -> [:meditations]
      :legal_privacy -> [:meditations]
      :legal_terms_and_conditions -> [:meditations]

      # PROGRAMS
      :programs_accountability -> [:meditations]
      :programs_reddit_guidelines -> [:meditations]
      :programs_coaching -> [:meditations, :contact_form_changeset]

      # VOLUNTEER
      :volunteer_helpful_neverfap_counsel -> [:meditations]
      :volunteer_engineering_corps -> [:meditations]
      :volunteer_marketing_department -> [:meditations]

      # APPS
      :apps_desktop_app -> [:meditations]
      :apps_mobile_app -> [:meditations]
      :apps_chrome_extension -> [:meditations]
      :apps_open_source -> [:meditations]
      :apps_neverfap_deluxe_league -> [:meditations]

      # MISC
      :misc_never_fap -> [:meditations]
      :misc_teens -> [:meditations]
      :misc_porn_addiction -> [:meditations]

      # CONTENT
      :articles -> apmss ++ []
      :article -> apmss ++ ccp ++ [:article]

      :practices -> apmss ++ []
      :practice -> apmss ++ ccp ++ [:practice]

      :meditations -> apmss ++ []
      :meditation -> apmss ++ ccp ++ [:meditation]

      :courses -> [:meditations, :courses]
      :course -> apmss ++ [:course]

      :podcasts -> apmss ++ [:podcasts]
      :podcast -> apmss ++ ccp ++ [:podcasts, :podcast]

      :quotes -> apmss ++ [:quotes]
      :quote -> apmss ++ ccp ++ [:quotes, :quote]

      :blogs -> [:meditations, :blogs]
      :blog -> apmss ++ ccp ++ [:blogs, :blog]

      :updates -> [:meditations, :updates]
      :update -> apmss ++ ccp ++ [:updates, :update]

      # CONTENT EMAIL
      :seven_day_kickstarter ->  [:meditations, :seven_day_kickstarter, :seven_day_kickstarter_changeset]
      :seven_day_kickstarter_single -> [:meditations, :seven_day_kickstarter_single, :course]

      :ten_day_meditation -> [:meditations, :ten_day_meditation]
      :ten_day_meditation_single -> [:meditations, :ten_day_meditation_single, :course]

      :twenty_eight_day_awareness -> [:meditations, :twenty_eight_day_awareness, :twenty_eight_day_awareness_changeset]
      :twenty_eight_day_awareness_single -> [:meditations, :twenty_eight_day_awareness_single, :course]

      :seven_week_awareness_vol_1 -> [:meditations, :seven_week_awareness_vol_1, :seven_week_awareness_vol_1_changeset]
      :seven_week_awareness_vol_1_single -> [:meditations, :seven_week_awareness_vol_1_single, :course]

      :seven_week_awareness_vol_2 -> [:meditations, :seven_week_awareness_vol_2, :seven_week_awareness_vol_2_changeset]
      :seven_week_awareness_vol_2_single -> [:meditations, :seven_week_awareness_vol_2_single, :course]

      :seven_week_awareness_vol_3 -> [:meditations, :seven_week_awareness_vol_3, :seven_week_awareness_vol_3_changeset]
      :seven_week_awareness_vol_3_single -> [:meditations, :seven_week_awareness_vol_3_single, :course]

      :seven_week_awareness_vol_4 -> [:meditations, :seven_week_awareness_vol_4, :seven_week_awareness_vol_4_changeset]
      :seven_week_awareness_vol_4_single -> [:meditations, :seven_week_awareness_vol_4_single, :course]

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
