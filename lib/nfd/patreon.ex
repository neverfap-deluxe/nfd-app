defmodule Nfd.Patreon do

  alias Nfd.Account
  alias Nfd.Account.User

  authorize_patreon_url = "https://www.patreon.com/oauth2/authorize"

  def validate_patreon_code(code, conn) do
    base_url = generate_base_url(conn.host)
    { :ok, response } = Tesla.get(
      "https://www.patreon.com/oauth2/authorize",
      query: [
        code: code,
        grant_type: "authorization_code",
        client_id: System.get_env(""),
        client_secret: System.get_env(""),
        redirect_uri: "#{base_url}/"
      ]
    )

    # information
    access_token = response.body["data"]["access_token"]
    refresh_token = response.body["data"]["refresh_token"]
    expires_in = response.body["data"]["expires_in"]

    # update user information
    user = Pow.Plug.current_user(conn)
    Account.update_user(user, %{
      patreon_linked: true,
      patreon_access_token: access_token,
      patreon_refresh_token: refresh_token,
      patreon_expires_in: expires_i]
    })

    # retrieve latest patreon information
    base_url = generate_base_url(conn.host)
    { :ok, response } = Tesla.get(
      "",
    )

    # %{
    #   access_token: response.body["data"]["access_token"],
    #   refresh_token: response.body["data"]["refresh_token"],
    #   expires_in: response.body["data"]["expires_in"],
    #   scope: response.body["data"]["scope"],
    #   token_type: response.body["data"]["token_type"]
    # }
  end

  def update_

  def refresh_patreon_token(patreon_refresh_token) do
    base_url = generate_base_url(conn.host)
    { :ok, response } = Tesla.get(
      "https://www.patreon.com/api/oauth2/token",
      query: [
        grant_type: "refresh_token",
        client_id: System.get_env(""),
        client_secret: System.get_env(""),
        refresh_token: patreon_refresh_token
      ]
    )

    # information
    access_token = response.body["data"]["access_token"]
    refresh_token = response.body["data"]["refresh_token"]
    expires_in = response.body["data"]["expires_in"]

    # update user information
    user = Pow.Plug.current_user(conn)
    Account.update_user(user, %{
      patreon_linked: true,
      patreon_access_token: access_token,
      patreon_refresh_token: refresh_token,
      patreon_expires_in: expires_i]
    })
  end


  # Helper Functions
  defp generate_base_url(host) do
    if host == "localhost" do
      "http://localhost:4000"
    else
      "https://neverfapdeluxe.com/"
    end
  end

  defp generate_relevant_patreon_auth_url(host) do
    base_url = generate_base_url(host)
    if host == "localhost" do
      "#{base_url}?response_type=code&client_id=TODO&redirect_uri=#{base_url}/"
    else
      "#{base_url}?response_type=code&client_id=#{System.get_env("PATREON_CLIENT_KEY")}&redirect_uri=#{base_url}/"
    end
  end

end
