use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with webpack to recompile .js and .css sources.
config :nfd, NfdWeb.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [
    node: [
      "node_modules/webpack/bin/webpack.js",
      "--mode",
      "development",
      "--watch-stdin",
      cd: Path.expand("../assets", __DIR__)
    ],
    node: [
      "node_modules/.bin/mjml-cli",
      "--watch",
      Path.expand("../assets/email_templates/lost_password.mjml", __DIR__),
      "-o",
      Path.expand("../lib/nfd_web/templates/email/lost_password.html.eex"),
      cd: Path.expand("../assets", __DIR__)
    ]

    # node: [
    #   "node_modules/.bin/mjml npx mjml",
    #   "--watch",
    #   "email_verification.mjml",
    #   "-o",
    #   "../../lib/nfd_web/templates/email/email_verification.html.eex",
    #   cd: Path.expand("../assets/email_templates", __DIR__)
    # ],
    # node: [
    #   "npx mjml",
    #   "--watch",
    #   "account_verified.mjml",
    #   "-o",
    #   "../../lib/nfd_web/templates/email/account_verified.html.eex",
    #   cd: Path.expand("../assets/email_templates", __DIR__)
    # ]

    # watch email template changes
  ]

# ## SSL Support
#
# In order to use HTTPS in development, a self-signed
# certificate can be generated by running the following
# Mix task:
#
#     mix phx.gen.cert
#
# Note that this task requires Erlang/OTP 20 or later.
# Run `mix help phx.gen.cert` for more information.
#
# The `http:` config above can be replaced with:
#
#     https: [
#       port: 4001,
#       cipher_suite: :strong,
#       keyfile: "priv/cert/selfsigned_key.pem",
#       certfile: "priv/cert/selfsigned.pem"
#     ],
#
# If desired, both `http:` and `https:` keys can be
# configured to run both http and https servers on
# different ports.

# Watch static and templates for browser reloading.
config :nfd, NfdWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{priv/gettext/.*(po)$},
      ~r{lib/nfd_web/views/.*(ex)$},
      ~r{lib/nfd_web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime

# Configure your database
config :nfd, Nfd.Repo,
  username: "postgres",
  password: "postgres",
  database: "nfd_dev",
  hostname: "localhost",
  pool_size: 10
