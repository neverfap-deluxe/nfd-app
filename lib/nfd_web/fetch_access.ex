defmodule NfdWeb.FetchAccess do
  def fetch_access_array(name) do
    case name do
      # PAGE CONTROLLERS
      # GENERAL
      :general_home -> [:articles, :practices, :meditations, :seven_day_kickstarter, :seven_day_kickstarter_changeset]
      :general_about -> [:contact_form_changeset]
      :general_contact -> [:contact_form_changeset]
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
      :article -> [:articles, :seven_day_kickstarter, :seven_day_kickstarter_changeset, :comments, :comment_form_changeset, :previous_next]

      :practices -> [:practices]
      :practice -> [:articles, :practices, :course, :seven_day_kickstarter, :seven_day_kickstarter_changeset, :comments, :comment_form_changeset, :previous_next]

      :courses -> [:courses]
      :course -> [:articles, :practices, :comments, :comment_form_changeset, :previous_next]

      :podcasts -> [:podcasts]
      :podcast -> [:podcasts, :comments, :comment_form_changeset, :previous_next]

      :quotes -> [:quotes]
      :quote -> [:quotes, :comments, :comment_form_changeset, :previous_next]

      :meditations -> [:meditations]
      :meditation -> [:meditations, :comments, :comment_form_changeset, :previous_next]

      :blogs -> [:blogs]
      :blog -> [:blogs, :comments, :comment_form_changeset, :previous_next]

      :updates -> [:updates]
      :update -> [:updates, :comments, :comment_form_changeset, :previous_next]

      # CONTENT EMAIL
      :seven_day_kickstarter ->  [:seven_day_kickstarter, :seven_day_kickstarter_changeset]
      :seven_day_kickstarter_single -> [:seven_day_kickstarter, :course]

      :ten_day_meditation ->  [:ten_day_meditation]
      :ten_day_meditation_single -> [:ten_day_meditation, :course]

      :twenty_eight_day_awareness ->  [:twenty_eight_day_awareness, :twenty_eight_day_awareness_changeset]
      :twenty_eight_day_awareness_single -> [:twenty_eight_day_awareness, :course]

      :seven_week_awareness_vol_1 ->  [:seven_week_awareness_vol_1, :seven_week_awareness_vol_1_changeset]
      :seven_week_awareness_vol_1_single -> [:seven_week_awareness_vol_1, :course]

      :seven_week_awareness_vol_2 ->  [:seven_week_awareness_vol_2, :seven_week_awareness_vol_2_changeset]
      :seven_week_awareness_vol_2_single -> [:seven_week_awareness_vol_2, :course]

      :seven_week_awareness_vol_3 ->  [:seven_week_awareness_vol_3, :seven_week_awareness_vol_3_changeset]
      :seven_week_awareness_vol_3_single -> [:seven_week_awareness_vol_3, :course]

      :seven_week_awareness_vol_4 ->  [:seven_week_awareness_vol_4, :seven_week_awareness_vol_4_changeset]
      :seven_week_awareness_vol_4_single -> [:seven_week_awareness_vol_4, :course]

      # DASHBOARD
      :dashboard -> [:courses, :ebooks, :purchased_ebooks, :purchased_courses, :not_purchased_ebooks, :not_purchased_courses, :patreon_auth_url]
      :dashboard_coaching -> [:stripe_session, :stripe_api_key, :paypal_api_key]

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
