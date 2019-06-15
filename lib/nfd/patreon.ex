defmodule Nfd.Patreon do
  use Timex
  use Tesla

  alias Tesla.Multipart

  alias Nfd.Account
  alias Nfd.Account.User

  api_patreon_url = "https://www.patreon.com/api/oauth2/v2/"

  # Helper Functions
  defp generate_base_url(host) do
    if host == "localhost" do
      "http://localhost:4000"
    else
      "https://neverfapdeluxe.com"
    end
  end

  defp auth_api_client(access_token) do
    middleware = [
      {Tesla.Middleware.BaseUrl, "https://www.patreon.com/api/oauth2/v2/"},
      Tesla.Middleware.JSON,
      {Tesla.Middleware.Headers, [{"Authorization", "Bearer #{access_token}" }]}
    ]

    Tesla.client(middleware)
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

    { :ok, response } = post("https://www.patreon.com/api/oauth2/token", mp, headers: [{"content-type", "x-www-form-urlencoded"}])
    body = Jason.decode!(response.body)
    auth_client = auth_api_client(body["access_token"])
    
    identity_url = "identity?include=memberships&fields%5Buser%5D=about,created,email,first_name,full_name,image_url,last_name,social_connections,thumb_url,url,vanity"

    { :ok, identityResponse } = auth_client |> get(identity_url)
    identity_body = Jason.decode!(identityResponse.body)

    update_user_information(conn, identity_body, body)
  end

  defp update_user_information(conn, identity_body, body) do 
    # retrieve latest patreon information to update on the profile.
    patreon_user_id = identity_body["data"]["id"]
    patreon_user_email = identity_body["data"]["attributes"]["email"]
    first_name = identity_body["data"]["attributes"]["first_name"]
    last_name = identity_body["data"]["attributes"]["last_name"]
    avatar_url = identity_body["data"]["attributes"]["image_url"]

    # update user information
    user = Pow.Plug.current_user(conn)
    
    Account.update_user(user, %{
      first_name: first_name,
      last_name: last_name,
      avatar_url: avatar_url,
      patreon_linked: true,
      patreon_user_id: patreon_user_id,
      patreon_user_email: patreon_user_email,
      patreon_access_token: body["access_token"],
      patreon_refresh_token: body["refresh_token"],
      # patreon_expires_in: body["expires_in"]
      patreon_expires_in: Timex.now
    })
  end

  def fetch_patreon(conn, user) do
    if user.patreon_linked do
      expires_in_date = user.patreon_expires_in
      seven_days_before_today = Timex.shift(Timex.today, days: 7)

      # check if date is already expired
      if Timex.after?(expires_in_date, Timex.now) do
        %{
          token_expired: true,
          is_valid_patron: false,
          currently_entitled_tiers: []
        }

      # if not expired check if it should be validated
      else
        if Timex.after?(expires_in_date, seven_days_before_today) do
          refresh_user_patreon_information(conn, user)
        end

        check_patreon_tier(conn, user)
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
    base_url = generate_base_url(conn.host)
    mp =
      Multipart.new
      |> Multipart.add_field("grant_type", "refresh_token")
      |> Multipart.add_field("client_id", System.get_env("PATREON_CLIENT_KEY"))
      |> Multipart.add_field("client_secret", System.get_env("PATREON_SECRET_KEY"))
      |> Multipart.add_field("refresh_token", user.patreon_refresh_token)

    { :ok, response } = post("https://www.patreon.com/api/oauth2/token", mp, headers: [{"content-type", "x-www-form-urlencoded"}])
    body = Jason.decode!(response.body)
    auth_client = auth_api_client(body["access_token"])
    
    identity_url = "identity?include=memberships&fields%5Buser%5D=about,created,email,first_name,full_name,image_url,last_name,social_connections,thumb_url,url,vanity"

    { :ok, identityResponse } = auth_client |> get(identity_url)
    identity_body = Jason.decode!(identityResponse.body)

    update_user_information(conn, identity_body, body)
  end

  defp check_patreon_tier(conn, user) do
    # members_url = "members/#{user.patreon_user_id}?include=address,currently_entitled_tiers,user&fields%5Bmember%5D=full_name,is_follower,email,last_charge_date,last_charge_status,lifetime_support_cents,patron_status,currently_entitled_amount_cents,pledge_relationship_start,will_pay_amount_cents&fields%5Btier%5D=title&fields%5Buser%5D=full_name,hide_pledges"
    campaign_members_url = "campaigns/2462972/members?include=currently_entitled_tiers&fields%5Bmember%5D=email,patron_status,last_charge_status"
    auth_client = auth_api_client(user.patreon_access_token)

    { :ok, campaign_members_response } = auth_client |> get(campaign_members_url)
    campaign_members_body = Jason.decode!(campaign_members_response.body)

    # get correct member
    member = Enum.find(campaign_members_body["data"], &(&1["attributes"]["email"] == user.patreon_user_email))

    if member do
      currently_entitled_tiers = member["relationships"]["currently_entitled_tiers"]["data"]
      tiers = campaign_members_body["included"]
      complete_tiers = Enum.map(currently_entitled_tiers, fn(tier) -> 
        Enum.find(tiers, fn(complete_tier) -> 
          complete_tier["id"] == tier["id"]
        end)
      end)

      last_charge_status = member["attributes"]["last_charge_status"]
      patron_status = member["attributes"]["patron_status"]

      %{
        token_expired: false,
        is_valid_patron: last_charge_status == "Paid" and patron_status == "active_patron",
        currently_entitled_tiers: complete_tiers
      } 
    else 
      %{
        token_expired: false,
        is_valid_patron: false,
        currently_entitled_tiers: []
      }  
    end
  end

  def generate_relevant_patreon_auth_url(host) do    
    base_url = generate_base_url(host)
    authorize_patreon_url = "https://www.patreon.com/oauth2/authorize"
    scope = "campaigns%20identity%20campaigns.members%20identity.memberships"

    "#{authorize_patreon_url}?response_type=code&scope=#{scope}&client_id=#{System.get_env("PATREON_CLIENT_KEY")}&redirect_uri=#{base_url}/validate_patreon"
  end


end
