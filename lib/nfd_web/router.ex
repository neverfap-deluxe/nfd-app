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

    get "/about", PageController, :about
    get "/contact", PageController, :contact
  
    get "/guide", PageController, :guide
    get "/articles", PageController, :articles
    get "/articles/:slug", PageController, :article
    get "/practices", PageController, :practices
    get "/practices/:slug", PageController, :practice
    get "/courses", PageController, :courses
    get "/courses/:slug", PageController, :course
    get "/podcast", PageController, :podcasts
    get "/podcast/:slug", PageController, :podcast

    get "/disclaimer", PageController, :disclaimer
    get "/privacy", PageController, :privacy

    get "/confirm_email_begin", PageController, :confirm_email_begin

    get "/neverfap-deluxe-account", PageController, :account
  end

  scope "/", NfdWeb do
    pipe_through [:browser, :protected]

    get "/dashboard", DashboardController, :dashboard
    get "/dashboard/profile", DashboardController, :profile
    get "/dashboard/audio_courses", DashboardController, :audio_courses
    get "/dashboard/email_challenges", DashboardController, :email_challenges

    delete "/logout", SessionController, :delete, as: :logout
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # Other scopes may use custom stacks.
  # scope "/api", NfdWeb do
  #   pipe_through :api
  # end
end
