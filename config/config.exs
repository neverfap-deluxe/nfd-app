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

  kickstarter_day_0_title: "The Introduction",
  kickstarter_day_1_title: "The Trust",
  kickstarter_day_2_title: "The Awareness",
  kickstarter_day_3_title: "The Calmness",
  kickstarter_day_4_title: "The Meditation",
  kickstarter_day_5_title: "The Relapse",
  kickstarter_day_6_title: "The Consistency",
  kickstarter_day_7_title: "The Community",

  # TODO: Fill out these titles
  primer_day_0_title: "The Introduction",
  primer_day_1_title: "Meditation Basics",
  primer_day_2_title: "Understanding The Purpose Of Meditation",
  primer_day_3_title: "Developing Our Capacity For Awareness",
  primer_day_4_title: "Embracing Calmness",
  primer_day_5_title: "Observing What You See",
  primer_day_6_title: "Observing What You Hear",
  primer_day_7_title: "Observing What You Feel",
  primer_day_8_title: "Feeling Empowered",
  primer_day_9_title: "Acknowledgement",
  primer_day_10_title: "Acceptance",

  challenge_day_0_title: "",
  challenge_day_1_title: "",
  challenge_day_2_title: "",
  challenge_day_3_title: "",
  challenge_day_4_title: "",
  challenge_day_5_title: "",
  challenge_day_6_title: "",
  challenge_day_7_title: "",
  challenge_day_8_title: "",
  challenge_day_9_title: "",
  challenge_day_10_title: "",
  challenge_day_11_title: "",
  challenge_day_12_title: "",
  challenge_day_13_title: "",
  challenge_day_14_title: "",
  challenge_day_15_title: "",
  challenge_day_16_title: "",
  challenge_day_17_title: "",
  challenge_day_18_title: "",
  challenge_day_19_title: "",
  challenge_day_20_title: "",
  challenge_day_21_title: "",
  challenge_day_22_title: "",
  challenge_day_23_title: "",
  challenge_day_24_title: "",
  challenge_day_25_title: "",
  challenge_day_26_title: "",
  challenge_day_27_title: "",
  challenge_day_28_title: "",

  seven_week_vol_1_day_0_title: "",
  seven_week_vol_1_day_1_title: "Expressing Gratitude",
  seven_week_vol_1_day_2_title: "Focus On Your Finger And Your Background",
  seven_week_vol_1_day_3_title: "Relax Everything",
  seven_week_vol_1_day_4_title: "Slow Down Time",
  seven_week_vol_1_day_5_title: "Identify Points Of Awareness Throughout The Day",
  seven_week_vol_1_day_6_title: "Can You Look Through Walls?",
  seven_week_vol_1_day_7_title: "Looking Straight Ahead",

  seven_week_vol_2_day_0_title: "",
  seven_week_vol_2_day_1_title: "Take Note Of The Colour Yellow",
  seven_week_vol_2_day_2_title: "Dissolve Your Visual Field",
  seven_week_vol_2_day_3_title: "Catch Out Your Judgements",
  seven_week_vol_2_day_4_title: "What Can Your Hand Do",
  seven_week_vol_2_day_5_title: "Stop Abolutely Everything You Are Doing",
  seven_week_vol_2_day_6_title: "Developing Routine",
  seven_week_vol_2_day_7_title: "Blind Attention",

  seven_week_vol_3_day_0_title: "",
  seven_week_vol_3_day_1_title: "Where Do You Touch",
  seven_week_vol_3_day_2_title: "Use Your Opposite Hand",
  seven_week_vol_3_day_3_title: "Who Is Looking?",
  seven_week_vol_3_day_4_title: "Identifying The Feeling Of Obligation",
  seven_week_vol_3_day_5_title: "Engaging Expression",
  seven_week_vol_3_day_6_title: "Object Attachment",
  seven_week_vol_3_day_7_title: "Slow Spinning Circle",

  seven_week_vol_4_day_0_title: "",
  seven_week_vol_4_day_1_title: "Annoy Yourself",
  seven_week_vol_4_day_2_title: "Just Do, Don't Think",
  seven_week_vol_4_day_3_title: "Fighting Spirit",
  seven_week_vol_4_day_4_title: "Catching The Odd Judge Out",
  seven_week_vol_4_day_5_title: "Control The Intonation of Your Breath",
  seven_week_vol_4_day_6_title: "Every 30 Minutes",
  seven_week_vol_4_day_7_title: "Focus Your Attention",

  general_type: "generalemail",
  kickstarter_type: "neverfapdeluxekickstarter",
  meditation_primer_type: "meditationprimer",
  awareness_challenge_type: "awarenesschallenge",

  awareness_seven_week_vol_1_type: "awareness_week_vol_1",
  awareness_seven_week_vol_2_type: "awareness_week_vol_2",
  awareness_seven_week_vol_3_type: "awareness_week_vol_3",
  awareness_seven_week_vol_4_type: "awareness_week_vol_4"

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
