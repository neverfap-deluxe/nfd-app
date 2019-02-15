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
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"



# CUSTOM CONFIG 

config :nfd, :pow,
  user: Nfd.Users.User,
  repo: Nfd.Repo

