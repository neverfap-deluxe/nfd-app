defmodule NfdWeb.PageController do
  use NfdWeb, :controller

  use Tesla
  alias Nfd.API

  alias NfdWeb.Fetch
  alias NfdWeb.FetchConn
  alias NfdWeb.FetchAccess

  # GENERAL
  def general_home(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.PageView, :general_home, "home.html", FetchAccess.fetch_access_array(:general_home))
  def general_about(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.PageView, :general_about, "general.html", FetchAccess.fetch_access_array(:general_about))
  def general_contact(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.PageView, :general_contact, "general.html", FetchAccess.fetch_access_array(:general_contact))
  def general_community(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.PageView, :general_community, "general.html", FetchAccess.fetch_access_array(:general_community))
  def general_donations(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.PageView, :general_donations, "general.html", FetchAccess.fetch_access_array(:general_donations))
  def general_everything(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.PageView, :general_everything, "general.html", FetchAccess.fetch_access_array(:general_everything))
  def general_premium(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.PageView, :general_premium, "general.html", FetchAccess.fetch_access_array(:general_premium))
  # GENERAL END

  # GUIDES
  def guides_guide(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.PageView, :guides_guide, "general.html", FetchAccess.fetch_access_array(:guides_guide))
  def guides_summary(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.PageView, :guides_summary, "general.html", FetchAccess.fetch_access_array(:guides_summary))
  def guides_neverfap_deluxe_bible(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.PageView, :guides_neverfap_deluxe_bible, "general.html", FetchAccess.fetch_access_array(:guides_neverfap_deluxe_bible))
  def guides_emergency(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.PageView, :guides_emergency, "home.html", FetchAccess.fetch_access_array(:guides_emergency))
  def guides_post_relapse_academy(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.PageView, :guides_post_relapse_academy, "home.html", FetchAccess.fetch_access_array(:guides_post_relapse_academy))
  def guides_complete_understanding(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.PageView, :guides_complete_understanding, "general.html", FetchAccess.fetch_access_array(:guides_complete_understanding))
  def guides_curriculum(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.PageView, :guides_curriculum, "general.html", FetchAccess.fetch_access_array(:guides_curriculum))
  def guides_fundamental_meditation_series(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.PageView, :guides_fundamental_meditation_series, "general.html", FetchAccess.fetch_access_array(:guides_fundamental_meditation_series))
  # GUIDES END

  # PROGRAMS
  def programs_accountability(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.PageView, :programs_accountability, "general.html", FetchAccess.fetch_access_array(:programs_accountability))
  def programs_reddit_guidelines(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.PageView, :programs_reddit_guidelines, "general.html", FetchAccess.fetch_access_array(:programs_reddit_guidelines))
  def programs_coaching(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.PageView, :programs_coaching, "general.html", FetchAccess.fetch_access_array(:programs_coaching))
  # PROGRAMS END

  # VOLUNTEER
  def volunteer_helpful_neverfap_counsel(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.PageView, :volunteer_helpful_neverfap_counsel, "general.html", FetchAccess.fetch_access_array(:volunteer_helpful_neverfap_counsel))
  def volunteer_engineering_corps(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.PageView, :volunteer_engineering_corps, "general.html", FetchAccess.fetch_access_array(:volunteer_engineering_corps))
  def volunteer_marketing_department(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.PageView, :volunteer_marketing_department, "general.html", FetchAccess.fetch_access_array(:volunteer_marketing_department))
  # VOLUNTEER END

  # APPS
  def apps_desktop_app(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.PageView, :apps_desktop_app, "general.html", FetchAccess.fetch_access_array(:apps_desktop_app))
  def apps_mobile_app(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.PageView, :apps_mobile_app, "general.html", FetchAccess.fetch_access_array(:apps_mobile_app))
  def apps_chrome_extension(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.PageView, :apps_chrome_extension, "general.html", FetchAccess.fetch_access_array(:apps_chrome_extension))
  def apps_open_source(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.PageView, :apps_open_source, "general.html", FetchAccess.fetch_access_array(:apps_open_source))
  def apps_neverfap_deluxe_league(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.PageView, :apps_neverfap_deluxe_league, "general.html", FetchAccess.fetch_access_array(:apps_neverfap_deluxe_league))
  def apps_hovering(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.PageView, :apps_hovering, "general.html", FetchAccess.fetch_access_array(:apps_hovering))
  # APPS END

  # LEGAL
  def legal_disclaimer(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.PageView, :legal_disclaimer, "general.html", FetchAccess.fetch_access_array(:legal_disclaimer))
  def legal_privacy(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.PageView, :legal_privacy, "general.html", FetchAccess.fetch_access_array(:legal_privacy))
  def legal_terms_and_conditions(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.PageView, :legal_terms_and_conditions, "general.html", FetchAccess.fetch_access_array(:legal_terms_and_conditions))
  # LEGAL END

  # MISC
  def misc_never_fap(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.PageView, :misc_never_fap, "general.html", FetchAccess.fetch_access_array(:misc_never_fap))
  def misc_teens(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.PageView, :misc_teens, "general.html", FetchAccess.fetch_access_array(:misc_teens))
  def misc_porn_addiction(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.PageView, :misc_porn_addiction, "general.html", FetchAccess.fetch_access_array(:misc_porn_addiction))
  def misc_porn_addiction_quiz(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.PageView, :misc_porn_addiction_quiz, "general.html", FetchAccess.fetch_access_array(:misc_porn_addiction_quiz))
  # MISC END

  # Images
  def test(conn, _params), do: conn |> render("test.html")
  def season_one(conn, _params), do: conn |> render("season_one.html")
  def season_two(conn, _params), do: conn |> render("season_two.html")

  def apple_podcast_xml(conn, _params) do
    client = API.is_localhost(conn.host) |> API.api_client()

    case Tesla.get(client, "http://rss.castbox.fm/everest/aab82e46f0cd4791b1c8ddc19d5158c3.xml") do
      {:ok, response} ->
        regex = ~r/https:\/\/s3.castbox.fm(\/*[a-zA-Z0-9])*.png/
        # does_match = Regex.match?(regex, "https://s3.castbox.fm/89/8f/d7/ab55544abb81506d8240808921.png") |> IO.inspect
        new_xml =
          Regex.replace(
            regex,
            response.body,
            "https://neverfapdeluxe.com/images/logo_podcast.png",
            global: true
          )

        conn
        |> put_resp_content_type("text/xml")
        |> send_resp(200, new_xml)

      {:error, error} ->
        FetchConn.render_404_page(conn, error)
    end
  end
end
