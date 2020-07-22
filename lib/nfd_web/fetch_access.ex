defmodule NfdWeb.FetchAccess do
  defp apmss do
    [:articles, :practices, :podcasts, :meditations, :seven_day_kickstarter, :seven_day_kickstarter_changeset]
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
      :general_donations -> apmss ++ []
      :general_everything -> apmss ++ []
      :general_premium -> apmss ++ []
      # GENERAL END

      # GUIDES
      :guides_guide -> apmss ++ []
      :guides_summary -> apmss ++ []
      :guides_neverfap_deluxe_bible -> apmss ++ []
      :guides_emergency -> apmss ++ []
      :guides_post_relapse_academy -> apmss ++ []
      :guides_complete_understanding -> apmss ++ []
      :guides_curriculum -> apmss ++ []
      # :guides_fundamental_meditation_series -> apmss ++ []
      # GUIDES END

      # LEGAL
      :legal_disclaimer -> [:podcasts, :meditations]
      :legal_privacy -> [:podcasts, :meditations]
      :legal_terms_and_conditions -> [:podcasts, :meditations]
      # LEGAL END

      # PROGRAMS
      :programs_accountability -> apmss ++ []
      :programs_reddit_guidelines -> apmss ++ []
      :programs_coaching -> apmss ++ [:contact_form_changeset]
      # PROGRAMS END

      # VOLUNTEER
      :volunteer_helpful_neverfap_counsel -> apmss ++ []
      :volunteer_engineering_corps -> apmss ++ []
      :volunteer_marketing_department -> apmss ++ []
      # VOLUNTEER END

      # APPS
      :apps_desktop_app -> apmss ++ []
      :apps_mobile_app -> apmss ++ []
      :apps_chrome_extension -> apmss ++ []
      :apps_open_source -> apmss ++ []
      :apps_neverfap_deluxe_league -> apmss ++ []
      :apps_hovering -> apmss ++ []
      # APPS END

      # MISC
      :misc_never_fap -> apmss ++ []
      :misc_teens -> apmss ++ []
      :misc_porn_addiction -> apmss ++ []
      :misc_porn_addiction_quiz -> apmss ++ []
      # MISC END

      # CONTENT
      :articles -> apmss ++ []
      :article -> apmss ++ ccp ++ [:article]

      :practices -> apmss ++ []
      :practice -> apmss ++ ccp ++ [:practice]

      :meditations -> apmss ++ []
      :meditation -> apmss ++ ccp ++ [:meditation]

      :courses -> apmss ++ [:courses]
      :course -> apmss ++ [:course]

      :podcasts -> apmss ++ []
      :podcast -> apmss ++ ccp ++ [:podcast]

      :quotes -> apmss ++ [:quotes]
      :quote -> apmss ++ ccp ++ [:quotes, :quote]

      :blogs -> apmss ++ [:blogs]
      :blog -> apmss ++ ccp ++ [:blogs, :blog]

      :updates -> apmss ++ [:updates]
      :update -> apmss ++ ccp ++ [:updates, :update]
      # CONTENT END

      # CONTENT EMAIL
      :seven_day_kickstarter -> [:meditations, :seven_day_kickstarter, :seven_day_kickstarter_changeset]
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
      # CONTENT EMAIL END

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
      # DASHBOARD END

    end
  end
end
