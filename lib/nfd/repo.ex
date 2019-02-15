defmodule Nfd.Repo do
  use Ecto.Repo,
    otp_app: :nfd,
    adapter: Ecto.Adapters.Postgres
end
