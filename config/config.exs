# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

alias Nfd.Sitemaps
alias Nfd.Emails

config :nfd,
  ecto_repos: [Nfd.Repo],
  base_url: "https://neverfapdeluxe.com/",
  author: "Julius Reade",
  logo: "https://neverfapdeluxe.com/images/logo.png",
  logo__small: "https://neverfapdeluxe.com/images/logo__small.png",
  google_analytics_url: "UA-132863786-1",
  website_name: "NeverFap Deluxe",

  social_facebook_url: "https://www.facebook.com/NeverFapDeluxe",
  social_twitter_url: "https://twitter.com/NeverFapDeluxe",
  social_reddit_url: "https://www.reddit.com/r/NeverFapDeluxe",
  social_reddit_user_url: "https://www.reddit.com/user/NeverFapDeluxe",
  social_patreon_url: "https://www.patreon.com/NeverFapDeluxe",
  social_discord_url: "https://discord.gg/YETRkSj",
  social_instagram_url: "https://www.instagram.com/neverfap_deluxe",
  social_tumblr_url: "https://neverfapdeluxe.tumblr.com/",
  social_pinterest_url: "https://www.pinterest.com.au/neverfapdeluxe/",
  social_youtube_url: "https://www.youtube.com/channel/UCHiMNZ86_zwW1RebKDcZEoQ/",
  social_github_url: "https://github.com/neverfap-deluxe",
  social_chrome_url: "https://chrome.google.com/webstore/detail/neverfap-deluxe/fojalkcicjfcnekjmchgpbibinkpikgd",
  social_firefox_url: "https://addons.mozilla.org/en-US/firefox/addon/neverfap-deluxe/?src=search",
  social_android_url: "https://play.google.com/store/apps/details?id=com.ueno.nfdmobilev2",
  social_ios_url: "null",
  social_paypal_url: "https://www.paypal.me/neverfapdeluxe",

  general_type: "generalemail",
  kickstarter_type: "neverfapdeluxekickstarter",
  meditation_primer_type: "meditationprimer",
  awareness_challenge_type: "awarenesschallenge"

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

    # Email Scheduler - Runs every midnight:
    {"@daily", {Emails, :email_scheduler, []}}, # "0 12 * * *

    # Sitemap Scheduler - Runs every midnight:
    {"@daily", {Sitemaps, :generate, []}}, # "0 12 * * *
  ]
