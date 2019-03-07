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
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  scope "/" do
    pipe_through :browser

    pow_routes() # Because I'm using custom routes defined below, this isn't needed.
    pow_extension_routes()
    pow_assent_routes()
  end

  scope "/", NfdWeb do
    pipe_through :browser

    get "/", PageController, :home
    get "/guide", PageController, :guide
    get "/neverfap-deluxe-account", PageController, :account
    get "/about", PageController, :about
    get "/contact", PageController, :contact
    get "/disclaimer", PageController, :disclaimer
    get "/privacy", PageController, :privacy

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

    get "/seven-day-kickstarter", PageController, :seven_day_kickstarter
    get "/seven-day-kickstarter/:day", PageController, :seven_day_kickstarter_day
    get "/twenty-eight-day-awareness-challenge", PageController, :twenty_eight_day_awareness
    get "/twenty-eight-day-awareness-challenge/:day", PageController, :twenty_eight_day_awareness_day
    get "/ten-day-meditation-primer", PageController, :ten_day_meditation
    get "/ten-day-meditation-primer/:day", PageController, :ten_day_meditation
  end

  scope "/", NfdWeb do
    pipe_through [:browser, :protected]

    get "/dashboard", DashboardController, :dashboard
    get "/dashboard/profile", DashboardController, :profile

    get "/dashboard/audio_courses", DashboardController, :audio_courses
    get "/dashboard/audio_courses/:collection", DashboardController, :audio_courses_collection
    get "/dashboard/audio_courses/:collection/:file", DashboardController, :audio_courses_single

    get "/dashboard/email_challenges", DashboardController, :email_challenges
    get "/dashboard/email_challenges/:collection", DashboardController, :email_challenges_collection
    get "/dashboard/email_challenges/:collection/:file", DashboardController, :email_challenges_single

    delete "/logout", SessionController, :delete, as: :logout
  end

  scope "/dev" do
    pipe_through [:browser]
    forward "/mailbox", Plug.Swoosh.MailboxPreview, [base_path: "/dev/mailbox"]
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # Other scopes may use custom stacks.
  # scope "/api", NfdWeb do
  #   pipe_through :api
  # end
end
