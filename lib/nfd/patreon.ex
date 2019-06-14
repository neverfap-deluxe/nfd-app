defmodule Nfd.Patreon do
  use Timex
  alias Tesla.Multipart

  alias Nfd.Account
  alias Nfd.Account.User

  authorize_patreon_url = "https://www.patreon.com/oauth2/authorize"

  # Helper Functions
  defp generate_base_url(host) do
    if host == "localhost" do
      "http://localhost:4000"
    else
      "https://neverfapdeluxe.com"
    end
  end

  def validate_patreon_code(conn, code) do
    base_url = generate_base_url(conn.host)
    mp =
      Multipart.new
      |> Multipart.add_field("code", code)
      |> Multipart.add_field("grant_type", "authorization_code")
      |> Multipart.add_field("client_id", System.get_env("PATREON_CLIENT_KEY"))
      |> Multipart.add_field("client_secret", System.get_env("PATREON_SECRET_KEY"))
      |> Multipart.add_field("redirect_uri", "#{base_url}/validate_patreon")

    { :ok, response } = Tesla.post("https://www.patreon.com/api/oauth2/token", mp, headers: [{"content-type", "x-www-form-urlencoded"}])

    # retrieve latest patreon information to update on the profile.
    { :ok, identityResponse } = Tesla.get(URI.encode_www_form("https://www.patreon.com/api/oauth2/v2/identity?fields[user]=about,created,email,first_name,full_name,image_url,last_name,social_connections,thumb_url,url,vanity"))
    
    IO.inspect identityResponse

    user_id = identityResponse["data"]["id"]

    # update user information
    user = Pow.Plug.current_user(conn)
    Account.update_user(user, %{
      patreon_linked: true,
      patreon_user_id: user_id,
      patreon_access_token: response.body["data"]["access_token"],
      patreon_refresh_token: response.body["data"]["refresh_token"],
      patreon_expires_in: response.body["data"]["expires_in"]
    })
  end

  def fetch_patreon(conn, user) do
    if user.patreon_linked do
      expires_in_date = Timex.format!(user.patreon_expires_in, "{ISO:Extended}")

      seven_days_before_today = Timex.shift(Timex.today, days: 7)

      # check if date is already expired
      if Timex.after?(expires_in_date, Today.today) do
        %{
          token_expired: true,
          is_valid_patron: false,
          currently_entitled_tiers: []
        }

      # if not expired check if it should be validated
      else
        if Timex.before?(Timex.today, seven_days_before_today) do
          Patreon.refresh_user_patreon_information(conn, user)
        end
        Patreon.check_patreon_tier(conn, user)
      end
    else
      %{
        token_expired: false,
        is_valid_patron: false,
        currently_entitled_tiers: []
      }
    end
  end

  defp refresh_user_patreon_information(conn, user) do
    { :ok, response } = Tesla.get(
      "https://www.patreon.com/api/oauth2/token",
      query: [
        grant_type: "refresh_token",
        client_id: System.get_env("PATREON_CLIENT_KEY"),
        client_secret: System.get_env("PATREON_SECRET_KEY"),
        refresh_token: user.patreon_refresh_token
      ]
    )

    # update user information
    Account.update_user(user, %{
      patreon_linked: true,
      patreon_access_token: response.body["data"]["access_token"],
      patreon_refresh_token: response.body["data"]["refresh_token"],
      patreon_expires_in: response.body["data"]["expires_in"]
    })
  end

  defp check_patreon_tier(conn, user) do
    base_url = generate_base_url(conn.host)
    { :ok, response } = Tesla.get(
      URI.encode_www_form("https://www.patreon.com/api/oauth2/v2/members/#{user.patreon_user_id}?include=address,currently_entitled_tiers,user&fields[member]=full_name,is_follower,email,last_charge_date,last_charge_status,lifetime_support_cents,patron_status,currently_entitled_amount_cents,pledge_relationship_start,will_pay_amount_cents&fields%5Btier%5D=title&fields%5Buser%5D=full_name,hide_pledges")
    )

    attributes = response["data"]["attributes"]
    last_charge_status = attributes["last_charge_status"]
    patron_status = attributes["patron_status"]

    relationships = response["data"]["relationships"]
    currently_entitled_tiers = relationships["currently_entitled_tiers"]["data"]

    %{
      token_expired: false,
      is_valid_patron: last_charge_status == "Paid" and patron_status == "active_patron",
      currently_entitled_tiers: currently_entitled_tiers
    }
  end

  def generate_relevant_patreon_auth_url(host) do
    base_url = generate_base_url(host)
    scope = "campaigns%20identity%20campaigns.members%20identity.memberships"

    "https://www.patreon.com/oauth2/authorize?response_type=code&scope=#{scope}&client_id=#{System.get_env("PATREON_CLIENT_KEY")}&redirect_uri=#{base_url}/validate_patreon"
  end

end
