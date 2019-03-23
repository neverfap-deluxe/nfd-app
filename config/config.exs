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
  author: "Julius Reade",
  logo: "/images/logo.png",
  google_analytics_url: "UA-132863786-1",

  social_facebook_url: "https://www.facebook.com/NeverFap-Deluxe-2203366683036015/",
  social_twitter_url: "https://twitter.com/NeverFapDeluxe",
  social_reddit_url: "https://www.reddit.com/user/NeverFapDeluxe",
  social_patreon_url: "https://www.patreon.com/NeverFapDeluxe",
  social_discord_url: "https://discord.gg/TuwARWk",

  seven_day_kickstarter_day_0_title: "The Beginning",
  seven_day_kickstarter_day_1_title: "The Meditation",
  seven_day_kickstarter_day_2_title: "The Awareness",
  seven_day_kickstarter_day_3_title: "The Calmness",
  seven_day_kickstarter_day_4_title: "The Trust",
  seven_day_kickstarter_day_5_title: "The Relapse",
  seven_day_kickstarter_day_6_title: "The Ambition",
  seven_day_kickstarter_day_7_title: "The Consistency"


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

# if Mix.env() == :dev do 
#   import_config "#{Mix.env()}.secret.exs"
# end

# CUSTOM CONFIG 

config :tesla, adapter: Tesla.Adapter.Hackney

config :phoenix, :format_encoders,
  json: Jason

config :nfd, :pow,
  user: Nfd.Account.User,
  repo: Nfd.Repo,
  extensions: [PowResetPassword, PowEmailConfirmation],
  controller_callbacks: Pow.Extension.Phoenix.ControllerCallbacks,
  mailer_backend: NfdWeb.PowMailer,
  routes_backend: NfdWeb.Pow.Routes,
  web_mailer_module: NfdWeb,
  web_module: NfdWeb

# Admin backend
# config :torch,
#   otp_app: :nfd,
#   template_format: "eex"

# Cron setup
config :nfd, Nfd.Scheduler,
  jobs: [
    # 28 day challenge
    # Every minute
    # {"* * * * *", {Sitemaps, :generate, []}},
    # Every 15 minutes
    # {"*/15 * * * *",   fn -> System.cmd("rm", ["/tmp/tmp_"]) end},
    # Runs on 18, 20, 22, 0, 2, 4, 6:
    # {"0 18-6/2 * * *", fn -> :mnesia.backup('/var/backup/mnesia') end},
    # Runs every midnight:
    # {"@daily",         {Backup, :backup, []%>
    {"@daily", {Sitemaps, :generate, []}}, # "0 12 * * *
  ]
