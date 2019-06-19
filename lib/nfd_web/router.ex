defmodule NfdWeb.Router do
  use NfdWeb, :router
  use Pow.Phoenix.Router
  use Pow.Extension.Phoenix.Router, otp_app: :nfd
  use PowAssent.Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug NavigationHistory.Tracker
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
    pow_extension_routes()
    pow_assent_routes()
  end

  scope "/", NfdWeb do
    pipe_through :browser

    # GENERAL
    get "/", PageController, :general_home
    get "/about", PageController, :general_about
    get "/contact", PageController, :general_contact
    get "/community", PageController, :general_community
    get "/donations", PageController, :general_donations
    get "/everything", PageController, :general_everything
    get "/premium", PageController, :general_premium

    # GUIDES
    get "/guide", PageController, :guides_guide
    get "/summary", PageController, :guides_summary
    get "/neverfap-deluxe-bible", PageController, :guides_neverfap_deluxe_bible
    get "/post-relapse-academy", PageController, :guides_post_relapse_academy
    get "/emergency", PageController, :guides_emergency

    # PROGRAMS
    get "/accountability-program", PageController, :programs_accountability
    get "/new-fap-deluxe-reddit-guidelines", PageController, :programs_reddit_guidelines
    get "/new-neverfapper-reddit-guidelines", PageController, :programs_reddit_guidelines
    get "/coaching", PageController, :programs_coaching

    # VOLUNTEER
    get "/helpful-neverfappers-academy", PageController, :volunteer_helpful_neverfap_counsel
    get "/helpful-neverfap-counsel", PageController, :volunteer_helpful_neverfap_counsel
    get "/engineering-corps", PageController, :volunteer_engineering_corps
    get "/marketing-department", PageController, :volunteer_marketing_department

    # APPS
    get "/desktop-app", PageController, :apps_desktop_app
    get "/mobile-app", PageController, :apps_mobile_app
    get "/chrome-extension", PageController, :apps_chrome_extension
    get "/neverfap-deluxe-league", PageController, :apps_neverfap_deluxe_league
    get "/neverfap-deluxe-open-source", PageController, :apps_open_source

    # MISC
    get "/never-fap", PageController, :misc_never_fap

    # LEGAL
    get "/disclaimer", PageController, :legal_disclaimer
    get "/privacy", PageController, :legal_privacy
    get "/terms-and-conditions", PageController, :legal_terms_and_conditions

    # IMAGES
    get "/test", PageController, :test
    get "/season-one", PageController, :season_one
    get "/season-two", PageController, :season_two

    # PODCAST
    get "/apple_podcast.xml", PageController, :apple_podcast_xml

    # CONTENT
    get "/articles", ContentController, :articles
    get "/articles/:slug", ContentController, :article
    get "/practices", ContentController, :practices
    get "/practices/:slug", ContentController, :practice
    get "/courses", ContentController, :courses
    get "/courses/:slug", ContentController, :course
    get "/podcast", ContentController, :podcasts
    get "/podcast/:slug", ContentController, :podcast
    get "/quotes", ContentController, :quotes
    get "/quotes/:slug", ContentController, :quote
    get "/meditation", ContentController, :meditations
    get "/meditation/:slug", ContentController, :meditation
    get "/blog", ContentController, :blogs
    get "/blog/:slug", ContentController, :blog
    get "/updates", ContentController, :updates
    get "/updates/:slug", ContentController, :update

    # CONTENT_EMAIL
    get "/seven-day-neverfap-deluxe-kickstarter", ContentEmailController, :seven_day_kickstarter
    get "/seven-day-neverfap-deluxe-kickstarter/:slug", ContentEmailController, :seven_day_kickstarter_single

    get "/twenty-eight-day-awareness-challenge", ContentEmailController, :twenty_eight_day_awareness
    get "/twenty-eight-day-awareness-challenge/:slug", ContentEmailController, :twenty_eight_day_awareness_single

    get "/ten-day-meditation-primer", ContentEmailController, :ten_day_meditation
    get "/ten-day-meditation-primer/:slug", ContentEmailController, :ten_day_meditation_single

    get "/seven-week-awareness-challenge-vol-1", ContentEmailController, :seven_week_awareness_vol_1
    get "/seven-week-awareness-challenge-vol-1/:slug", ContentEmailController, :seven_week_awareness_vol_1_single

    get "/seven-week-awareness-challenge-vol-2", ContentEmailController, :seven_week_awareness_vol_2
    get "/seven-week-awareness-challenge-vol-2/:slug", ContentEmailController, :seven_week_awareness_vol_2_single

    get "/seven-week-awareness-challenge-vol-3", ContentEmailController, :seven_week_awareness_vol_3
    get "/seven-week-awareness-challenge-vol-3/:slug", ContentEmailController, :seven_week_awareness_vol_3_single

    get "/seven-week-awareness-challenge-vol-4", ContentEmailController, :seven_week_awareness_vol_4
    get "/seven-week-awareness-challenge-vol-4/:slug", ContentEmailController, :seven_week_awareness_vol_4_single

  end

  # Functions
  scope "/", NfdWeb do
    pipe_through :browser

    # MESSAGE
    get "/upvote_comment", MessageController, :comment_upvote
    get "/delete_comment", MessageController, :comment_delete

    post "/send_comment", MessageController, :comment_form_post
    post "/send_message", MessageController, :contact_form_post

    get "/message_success", MessageController, :send_contact_form_success
    get "/message_failed", MessageController, :send_contact_form_failed

    # SUBSCRIPTION
    post "/confirm_subscription", SubscriptionController, :add_subscription_validate_matrix
    get "/subscription_success", SubscriptionController, :confirm_subscription_validate_matrix
    get "/unsubscribe", SubscriptionController, :unsubscribe_validate_matrix

    # FUNCTION
    get "/validate_patreon", FunctionController, :validate_patreon
    get "/change_subscription_dashboard_func", FunctionController, :change_subscription_dashboard_func
  end

  scope "/", NfdWeb do
    pipe_through [:browser, :protected]

    get "/dashboard", DashboardController, :dashboard
    get "/dashboard/profile", DashboardController, :profile
    get "/dashboard/delete_profile", DashboardController, :profile_delete_confirmation

    get "/dashboard/ebooks", DashboardController, :ebooks
    get "/dashboard/ebooks/:collection", DashboardController, :ebooks_collection
    get "/dashboard/ebooks/:collection/:file", DashboardController, :ebooks_single

    get "/dashboard/courses", DashboardController, :courses
    get "/dashboard/courses/:collection", DashboardController, :courses_collection

    get "/dashboard/courses/:collection/:file", DashboardController, :courses_single

    # PAYMENT
    post "/paypal_payment", PaymentController, :paypal_collection_payment
    post "/stripe_payment", PaymentController, :stripe_collection_payment

    get "/purchase_success", PaymentController, :purchase_success
    get "/purchase_cancel", PaymentController, :purchase_cancel
  end

  scope "/dev" do
    pipe_through [:browser]
    forward "/mailbox", Plug.Swoosh.MailboxPreview, base_path: "/dev/mailbox"
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # Other scopes may use custom stacks.
  # scope "/api", NfdWeb do
  #   pipe_through :api
  # end
end
