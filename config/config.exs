# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :nfd,
  ecto_repos: [Nfd.Repo]

# Configures the endpoint
config :nfd, NfdWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "gJBJhimWS0kQ/YU4YqYQmMkP3hl/z+euhjl5jH6H01IKBvfXXe9x2xPzDLx+T0Rm",
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

config :nfd, :pow,
  user: Nfd.Users.User,
  repo: Nfd.Repo,
  extensions: [PowResetPassword, PowEmailConfirmation],
  controller_callbacks: Pow.Extension.Phoenix.ControllerCallbacks,
  mailer_backend: NfdWeb.PowMailer,
  web_mailer_module: NfdWeb

config :nfd, :pow_assent,
  providers:
       [
        facebook: [
          client_id: "REPLACE_WITH_CLIENT_ID",
          client_secret: "REPLACE_WITH_CLIENT_SECRET",
          strategy: PowAssent.Strategy.Facebook
        ],
        google: [
          client_id: "REPLACE_WITH_CLIENT_ID",
          client_secret: "REPLACE_WITH_CLIENT_SECRET",
          strategy: PowAssent.Strategy.Google
        ],
        vk: [
          consumer_key: "REPLACE_WITH_CONSUMER_KEY",
          consumer_secret: "REPLACE_WITH_CONSUMER_SECRET",
          strategy: PowAssent.Strategy.Twitter
        ]
      ]

# Mailer setup
config :nfd, Nfd.SwooshMailer,
  adapter: Swoosh.Adapters.AmazonSES,
  region: "us-east-1",
  access_key: System.get_env("AWS_ACCESS_KEY"),
  secret: System.get_env("AWS_SECRET_KEY")


# Cron setup
# config :nfd, Nfd.Scheduler,
#   jobs: [
#     28 day challenge
#     Every minute
#     {"* * * * *",      {Heartbeat, :send, []}},
#     Every 15 minutes
#     {"*/15 * * * *",   fn -> System.cmd("rm", ["/tmp/tmp_"]) end},
#     Runs on 18, 20, 22, 0, 2, 4, 6:
#     {"0 18-6/2 * * *", fn -> :mnesia.backup('/var/backup/mnesia') end},
#     Runs every midnight:
#     {"@daily",         {Backup, :backup, []}}
#   ]
