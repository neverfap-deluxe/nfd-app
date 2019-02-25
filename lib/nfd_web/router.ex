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
      error_handler: NfdWeb.AuthErrorHandler # Pow.Phoenix.PlugErrorHandler
  end

  pipeline :not_authenticated do
    plug Pow.Plug.RequireNotAuthenticated,
      error_handler: NfdWeb.AuthErrorHandler
  end

  scope "/" do
    pipe_through :browser
    get "/", PageController, :home

    get "/about", PageController, :about
    get "/contact", PageController, :contact
  
    get "/articles", PageController, :articles
    get "/articles/:article_id", PageController, :article
    get "/practices", PageController, :practices
    get "/practices/:practice_id", PageController, :practice
    get "/courses", PageController, :courses
    get "/courses/:course_id", PageController, :course
    get "/podcasts", PageController, :podcasts
    get "/podcasts/:course_id", PageController, :podcast

    get "/disclaimer", PageController, :disclaimer
    get "/privacy", PageController, :privacy

    pow_routes() # Because I'm using custom routes defined below, this isn't needed.
    pow_extension_routes()
    pow_assent_routes()
  end

  scope "/", NfdWeb do
    pipe_through [:browser, :not_authenticated]

    get "/account", RegistrationController, :account

    get "/signup", RegistrationController, :new
    post "/signup", RegistrationController, :create
    get "/login", SessionController, :new
    post "/login", SessionController, :create
  end

  scope "/", NfdWeb do
    pipe_through [:browser, :protected]

    get "/dashboard", DashboardController, :dashboard
    get "/profile", DashboardController, :profile
    get "confirm_email_begin", RegistrationController, :confirm_email_begin

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
