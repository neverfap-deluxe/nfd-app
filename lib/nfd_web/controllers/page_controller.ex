defmodule NfdWeb.PageController do
  use NfdWeb, :controller

  alias NfdWeb.Fetch

  # GENERAL
  def home(conn, _params), do: Fetch.fetch_page(conn, :home, "home.html", [:articles, :seven_day_kickstarter, :seven_day_kickstarter_changeset])
  def about(conn, _params), do: Fetch.fetch_page(conn, :about, "general.html", [:contact_form_changeset])
  def contact(conn, _params), do: Fetch.fetch_page(conn, :contact, "general.html", [])
  def community(conn, _params), do: Fetch.fetch_page(conn, :community, "general.html", [])
  def donations(conn, _params), do: Fetch.fetch_page(conn, :donations, "general.html", [])
  def everything(conn, _params), do: Fetch.fetch_page(conn, :everything, "general.html", [])

  # GUIDES
  def guide(conn, _params), do: Fetch.fetch_page(conn, :guide, "general.html", [:articles, :seven_day_kickstarter, :seven_day_kickstarter_changeset])
  def summary(conn, _params), do: Fetch.fetch_page(conn, :summary, "general.html", [])
  def neverfap_deluxe_bible(conn, _params), do: Fetch.fetch_page(conn, :neverfap_deluxe_bible, "general.html", [])
  def emergency(conn, _params), do: Fetch.fetch_page(conn, :emergency, "home.html", [])
  def post_relapse_academy(conn, _params), do: Fetch.fetch_page(conn, :post_relapse_academy, "home.html", [])

  # LEGAL
  def disclaimer(conn, _params), do: Fetch.fetch_page(conn, :disclaimer, "general.html", [])
  def privacy(conn, _params), do: Fetch.fetch_page(conn, :privacy, "general.html", [])
  def terms_and_conditions(conn, _params), do: Fetch.fetch_page(conn, :terms_and_conditions, "general.html", [])

  # PROGRAMS
  def accountability(conn, _params), do: Fetch.fetch_page(conn, :accountability, "general.html", [])
  def reddit_guidelines(conn, _params), do: Fetch.fetch_page(conn, :reddit_guidelines, "general.html", [])
  def coaching(conn, _params), do: Fetch.fetch_page(conn, :coaching, "general.html", [])

  # VOLUNTEER
  def helpful_neverfap_counsel(conn, _params), do: Fetch.fetch_page(conn, :helpful_neverfap_counsel, "general.html", [])
  def engineering_corps(conn, _params), do: Fetch.fetch_page(conn, :engineering_corps, "general.html", [])
  def marketing_department(conn, _params), do: Fetch.fetch_page(conn, :marketing_department, "general.html", [])

  # APPS
  def desktop_app(conn, _params), do: Fetch.fetch_page(conn, :desktop_app, "general.html", [])
  def mobile_app(conn, _params), do: Fetch.fetch_page(conn, :mobile_app, "general.html", [])
  def chrome_extension(conn, _params), do: Fetch.fetch_page(conn, :chrome_extension, "general.html", [])
  def open_source(conn, _params), do: Fetch.fetch_page(conn, :open_source, "general.html", [])
  def neverfap_deluxe_league(conn, _params), do: Fetch.fetch_page(conn, :neverfap_deluxe_league, "general.html", [])

  # MISC
  def never_fap(conn, _params), do: Fetch.fetch_page(conn, :never_fap, "general.html", [])

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

      {:error, _error} ->
        render_404_page(conn)
    end
  end

  defp render_404_page(conn) do
    conn
    |> put_view(NfdWeb.ErrorView)
    |> render("404.html")
  end
end
