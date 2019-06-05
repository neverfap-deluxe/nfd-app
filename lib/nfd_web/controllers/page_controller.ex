defmodule NfdWeb.PageController do
  use NfdWeb, :controller

  alias Nfd.API
  alias Nfd.API.Page
  alias Nfd.API.Content
  alias Nfd.API.ContentEmail

  alias Nfd.Meta
  alias Nfd.Account.Subscriber
  alias Nfd.Account.ContactForm

  plug :put_layout, "general.html"

  def home(conn, _params) do
    page_type = "page"
    client = API.is_localhost(conn.host) |> API.api_client()

    seven_day_kickstarter_changeset = Subscriber.changeset(%Subscriber{}, %{})

    case client |> Page.home() do
      {:ok, response} ->
        Meta.increment_visit_count(response.body["data"])
        {:ok, articlesResponse} = client |> Content.articles()
        {:ok, sdkResponse} = client |> ContentEmail.seven_day_kickstarter()

        conn
        |> render("home.html",
          layout: {NfdWeb.LayoutView, "home.html"},
          item: response.body["data"],
          articles: articlesResponse.body["data"]["articles"] |> Enum.reverse(),
          seven_day_kickstarter_changeset: seven_day_kickstarter_changeset,
          sdkItem: sdkResponse.body["data"],
          page_type: page_type
        )

      {:error, _error} ->
        render_404_page(conn)
    end
  end


  def post_relapse_academy(conn, _params) do
    page_type = "page"
    client = API.is_localhost(conn.host) |> API.api_client()

    case client |> Page.post_relapse_academy() do
      {:ok, response} ->
        Meta.increment_visit_count(response.body["data"])

        conn
        |> render("post_relapse_academy.html",
          layout: {NfdWeb.LayoutView, "home.html"},
          item: response.body["data"],
          page_type: page_type
        )

      {:error, _error} ->
        render_404_page(conn)
    end
  end

  def emergency(conn, _params) do
    page_type = "page"
    client = API.is_localhost(conn.host) |> API.api_client()

    case client |> Page.emergency() do
      {:ok, response} ->
        Meta.increment_visit_count(response.body["data"])

        conn
        |> render("emergency.html",
          layout: {NfdWeb.LayoutView, "home.html"},
          item: response.body["data"],
          page_type: page_type
        )

      {:error, _error} ->
        render_404_page(conn)
    end
  end

  def guide(conn, _params) do
    page_type = "page"
    client = API.is_localhost(conn.host) |> API.api_client()

    seven_day_kickstarter_changeset = Subscriber.changeset(%Subscriber{}, %{})

    case client |> Page.guide() do
      {:ok, response} ->
        Meta.increment_visit_count(response.body["data"])
        {:ok, articlesResponse} = client |> Content.articles()
        {:ok, sdkResponse} = client |> ContentEmail.seven_day_kickstarter()

        conn
        |> render("guide.html",
          item: response.body["data"],
          articles: articlesResponse.body["data"]["articles"] |> Enum.reverse(),
          seven_day_kickstarter_changeset: seven_day_kickstarter_changeset,
          sdkItem: sdkResponse.body["data"],
          page_type: page_type
        )

      {:error, _error} ->
        render_404_page(conn)
    end
  end

  def community(conn, _params) do
    page_type = "page"
    client = API.is_localhost(conn.host) |> API.api_client()

    case client |> Page.community() do
      {:ok, response} ->
        Meta.increment_visit_count(response.body["data"])
        {:ok, articlesResponse} = client |> Content.articles()

        conn
        |> render("community.html",
          item: response.body["data"],
          articles: articlesResponse.body["data"]["articles"] |> Enum.reverse(),
          page_type: page_type
        )

      {:error, _error} ->
        render_404_page(conn)
    end
  end

  def about(conn, _params) do
    page_type = "page"
    client = API.is_localhost(conn.host) |> API.api_client()

    contact_form_changeset =
      ContactForm.changeset(%ContactForm{}, %{name: "", email: "", message: ""})

    case client |> Page.about() do
      {:ok, response} ->
        Meta.increment_visit_count(response.body["data"])

        conn
        |> render("about.html",
          item: response.body["data"],
          contact_form_changeset: contact_form_changeset,
          page_type: page_type
        )

      {:error, _error} ->
        render_404_page(conn)
    end
  end

  def contact(conn, _params), do: fetch_page(conn, "page", :contact)
  def disclaimer(conn, _params), do: fetch_page(conn, "page", :disclaimer)
  def privacy(conn, _params), do: fetch_page(conn, "page", :privacy)
  def terms_and_conditions(conn, _params), do: fetch_page(conn, "page", :terms_and_conditions)

  def accountability(conn, _params), do: fetch_page(conn, "page", :accountability)
  def reddit_guidelines(conn, _params), do: fetch_page(conn, "page", :reddit_guidelines)
  def everything(conn, _params), do: fetch_page(conn, "page", :everything)
  def coaching(conn, _params), do: fetch_page(conn, "page", :coaching)
  def donations(conn, _params), do: fetch_page(conn, "page", :donations)
  def summary(conn, _params), do: fetch_page(conn, "page", :summary)
  def neverfap_deluxe_bible(conn, _params), do: fetch_page(conn, "page", :neverfap_deluxe_bible)

  # VOLUNTEER
  def helpful_neverfap_counsel(conn, _params), do: fetch_page(conn, "page", :helpful_neverfap_counsel)
  def engineering_corps(conn, _params), do: fetch_page(conn, "page", :engineering_corps)
  def marketing_department(conn, _params), do: fetch_page(conn, "page", :marketing_department)

  # APPS
  def desktop_app(conn, _params), do: fetch_page(conn, "page", :desktop_app)
  def mobile_app(conn, _params), do: fetch_page(conn, "page", :mobile_app)
  def chrome_extension(conn, _params), do: fetch_page(conn, "page", :chrome_extension)
  def open_source(conn, _params), do: fetch_page(conn, "page", :open_source)
  def neverfap_deluxe_league(conn, _params), do: fetch_page(conn, "page", :neverfap_deluxe_league)

  # MISC
  def never_fap(conn, _params), do: fetch_page(conn, "page", :never_fap)

  defp fetch_page(conn, page_type, page_symbol) do
    client = API.is_localhost(conn.host) |> API.api_client()
    case apply(Nfd.API.Page, page_symbol, [client]) do
      {:ok, response} ->
        Meta.increment_visit_count(response.body["data"])

        conn
        |> render("#{Atom.to_string(page_symbol)}.html",
          item: response.body["data"],
          page_type: page_type
        )

      {:error, _error} ->
        render_404_page(conn)
    end
  end

  defp fetch_collections() do

  end

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
