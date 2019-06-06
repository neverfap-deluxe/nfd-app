defmodule NfdWeb.FetchCollection do
  def fetch_collections_array(name) do
    case name do
      # PAGE CONTROLLERS
      # GENERAL
      :home -> [:articles, :seven_day_kickstarter, :seven_day_kickstarter_changeset]
      :about -> [:contact_form_changeset]
      :contact -> []
      :community -> []
      :donations -> []
      :everything -> []

      # GUIDES
      :guide -> [:articles, :seven_day_kickstarter, :seven_day_kickstarter_changeset]
      :summary -> []
      :neverfap_deluxe_bible -> []
      :emergency -> []
      :post_relapse_academy -> []

      # LEGAL
      :disclaimer -> []
      :privacy -> []
      :terms_and_conditions -> []

      # PROGRAMS
      :accountability -> []
      :reddit_guidelines -> []
      :coaching -> []

      # VOLUNTEER
      :helpful_neverfap_counsel -> []
      :engineering_corps -> []
      :marketing_department -> []

      # APPS
      :desktop_app -> []
      :mobile_app -> []
      :chrome_extension -> []
      :open_source -> []
      :neverfap_deluxe_league -> []

      # MISC
      :never_fap -> []

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

      :audio_campaigns -> [:collections_audio]
      :audio_campaigns_collection -> [:collection_audio, :collections_audio, :stripe_api_key]
      :audio_campaigns_file -> [:collection_audio, :collections_audio, :collections_audio_file, :stripe_api_key]

      :profile -> []
      :profile_delete_confirmation -> []
    end
  end

end
