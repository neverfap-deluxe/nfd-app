# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

alias Nfd.Sitemaps

config :nfd,
  ecto_repos: [Nfd.Repo],
  base_url: "https://neverfapdeluxe.com/",
  website_author: "Julius Reade",
  website_logo_png: "/images/logo.png",
  website_alt_image: "/images/logo.png",
  language_code: "en-us",
  google_analytics: "UA-132863786-1"


# Configures the endpoint
config :nfd, NfdWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "w5eMCe3BbcBsDL/9CdnL2bVs243jn2WnlpD92UO2e2sF04f9wcsWUb1ZeOWARy2J",
  render_errors: [view: NfdWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Nfd.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id],
  level: :debug

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

# CUSTOM CONFIG 

config :tesla, adapter: Tesla.Adapter.Hackney

config :phoenix, :format_encoders,
  json: Jason

config :nfd, :pow,
  user: Nfd.Users.User,
  repo: Nfd.Repo,
  extensions: [PowResetPassword, PowEmailConfirmation],
  controller_callbacks: Pow.Extension.Phoenix.ControllerCallbacks,
  mailer_backend: NfdWeb.PowMailer,
  routes_backend: NfdWeb.Pow.Routes,
  web_mailer_module: NfdWeb,
  web_module: NfdWeb

  

# Cron setup
config :nfd, Nfd.Scheduler,
  jobs: [
    # 28 day challenge
    # Every minute
    # {"* * * * *",      {Heartbeat, :send, []%>,
    # Every 15 minutes
    # {"*/15 * * * *",   fn -> System.cmd("rm", ["/tmp/tmp_"]) end},
    # Runs on 18, 20, 22, 0, 2, 4, 6:
    # {"0 18-6/2 * * *", fn -> :mnesia.backup('/var/backup/mnesia') end},
    # Runs every midnight:
    # {"@daily",         {Backup, :backup, []%>
    # {"@daily", {Sitemaps, :generate, []}}, # "0 12 * * *
  ]
