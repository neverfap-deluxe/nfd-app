defmodule NfdWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :nfd
  # use NfdWeb.Endpoint, otp_app: :nfd

  socket "/socket", NfdWeb.UserSocket,
    websocket: true,
    longpoll: false

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phx.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/",
    from: :nfd,
    gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  plug Plug.Session,
    store: :cookie,
    key: "_nfd_key",
    signing_salt: "vsK5HnrP" # "secret"

  plug Pow.Plug.Session, 
    otp_app: :nfd,
    repo: Nfd.Repo, # not sure
    user: Nfd.Users.User, # not sure
    web_module: NfdWeb # not sure

  # Web Plugs
  plug NfdWeb.Router

  
  # This is what the instruction says when generating POW Assent templates, but it doesn't seem to be working?

  # Please set `web_module: NfdWeb` in your configuration.
  # defmodule NfdWeb.Endpoint do

  #   # ...

  #   plug NfdWeb.Pow.Plug.Session,
  #     repo: Nfd.Repo,
  #     user: Nfd.Users.User,
  #     web_module: NfdWeb

  #   # ...
  # end
end
