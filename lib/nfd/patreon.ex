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

    # auth information
    access_token = response.body["data"]["access_token"]
    refresh_token = response.body["data"]["refresh_token"]
    expires_in = response.body["data"]["expires_in"]

    # retrieve latest patreon information to update on the profile.
    { :ok, identityResponse } = Tesla.get(
      "https://www.patreon.com/api/oauth2/v2/identity?fields[user]=about,created,email,first_name,full_name,image_url,last_name,social_connections,thumb_url,url,vanity"
    )

    user_id = identityResponse["data"]["id"]

    # update user information
    user = Pow.Plug.current_user(conn)
    Account.update_user(user, %{
      patreon_linked: true,
      patreon_user_id: user_id,
      patreon_access_token: access_token,
      patreon_refresh_token: refresh_token,
      patreon_expires_in: expires_in,
    })
  end

  def check_patreon_tier(user, conn) do
    base_url = generate_base_url(conn.host)
    { :ok, response } = Tesla.get(
      "#{base_url}/#{user.patreon_user_id}?include=address,currently_entitled_tiers,user&fields[member]=full_name,is_follower,email,last_charge_date,last_charge_status,lifetime_support_cents,patron_status,currently_entitled_amount_cents,pledge_relationship_start,will_pay_amount_cents&fields%5Btier%5D=title&fields%5Buser%5D=full_name,hide_pledges",
    )

    attributes = response["data"]["attributes"]
    last_charge_status = attributes["last_charge_status"]
    patron_status = attributes["patron_status"]

    relationships = response["data"]["relationships"]
    currently_entitled_tiers = relationships["currently_entitled_tiers"]["data"]

    %{
      is_valid_patron: last_charge_status == "Paid" and patron_status == "active_patron",
      currently_entitled_tiers: currently_entitled_tiers
    }
  end

  def refresh_user_patreon_information(patreon_refresh_token) do
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
      "https://neverfapdeluxe.com"
    end
  end

  defp generate_relevant_patreon_auth_url(host) do
    base_url = generate_base_url(host)
    scope = "users pledges-to-me my-campaign campaigns.members"
    if host == "localhost" do
      "#{base_url}?response_type=code&scope=#{scope}&client_id=TODO&redirect_uri=#{base_url}/validate_patreon"
    else
      "#{base_url}?response_type=code&scope=#{scope}&client_id=#{System.get_env("PATREON_CLIENT_KEY")}&redirect_uri=#{base_url}/validate_patreon"
    end
  end

end
