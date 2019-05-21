defmodule NfdWeb.PageController do
  use NfdWeb, :controller

  alias Nfd.API
  alias Nfd.API.Page
  alias Nfd.API.Content
  
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

        header = 

        conn |> render("home.html", layout: {NfdWeb.LayoutView, "home.html"}, item: response.body["data"], articles: articlesResponse.body["data"]["articles"] |> Enum.reverse(), seven_day_kickstarter_changeset: seven_day_kickstarter_changeset, page_type: page_type)
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
        conn |> render("guide.html", item: response.body["data"], articles: articlesResponse.body["data"]["articles"] |> Enum.reverse(), seven_day_kickstarter_changeset: seven_day_kickstarter_changeset, page_type: page_type)
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
        conn |> render("community.html", item: response.body["data"], articles: articlesResponse.body["data"]["articles"] |> Enum.reverse(), page_type: page_type)
      {:error, _error} -> 
        render_404_page(conn)
    end
  end

  def about(conn, _params) do
    page_type = "page"
    client = API.is_localhost(conn.host) |> API.api_client()

    contact_form_changeset = ContactForm.changeset(%ContactForm{}, %{name: "", email: "", message: ""})
    
    case client |> Page.about() do
      {:ok, response} ->
        Meta.increment_visit_count(response.body["data"])
        conn |> render("about.html", item: response.body["data"], contact_form_changeset: contact_form_changeset, page_type: page_type)
      {:error, _error} -> 
        render_404_page(conn)
    end
  end

  def contact(conn, _params) do
    page_type = "page"
    client = API.is_localhost(conn.host) |> API.api_client()

    case client |> Page.contact() do
      {:ok, response} ->
        Meta.increment_visit_count(response.body["data"])
        conn |> render("contact.html", item: response.body["data"], page_type: page_type)
      {:error, _error} -> 
        render_404_page(conn)
    end
  end
  
  def disclaimer(conn, _params) do
    page_type = "page"
    client = API.is_localhost(conn.host) |> API.api_client()

    case client |> Page.disclaimer() do
      {:ok, response} ->
        Meta.increment_visit_count(response.body["data"])
        conn |> render("disclaimer.html", item: response.body["data"], page_type: page_type)
      {:error, _error} -> 
        render_404_page(conn)
    end
  end

  def privacy(conn, _params) do
    page_type = "page"
    client = API.is_localhost(conn.host) |> API.api_client()

    case client |> Page.privacy() do
      {:ok, response} ->
        Meta.increment_visit_count(response.body["data"])
        conn |> render("privacy.html", item: response.body["data"], page_type: page_type)
      {:error, _error} -> 
        render_404_page(conn)
    end
  end


  def terms_and_conditions(conn, _params) do
    page_type = "page"
    client = API.is_localhost(conn.host) |> API.api_client()

    case client |> Page.terms_and_conditions() do
      {:ok, response} ->
        Meta.increment_visit_count(response.body["data"])
        conn |> render("terms_and_conditions.html", item: response.body["data"], page_type: page_type)
      {:error, _error} -> 
        render_404_page(conn)
    end
  end

  def account(conn, _params) do
    changeset = Pow.Plug.change_user(conn)

    render(conn, "account.html", changeset: changeset)
  end

  def accountability(conn, _params) do
    page_type = "page"
    client = API.is_localhost(conn.host) |> API.api_client()

    case client |> Page.accountability() do
      {:ok, response} ->
        Meta.increment_visit_count(response.body["data"])
        conn |> render("accountability.html", item: response.body["data"], page_type: page_type)
      {:error, _error} -> 
        render_404_page(conn)
    end
  end

  def reddit_guidelines(conn, _params) do
    page_type = "page"
    client = API.is_localhost(conn.host) |> API.api_client()

    case client |> Page.reddit_guidelines() do
      {:ok, response} ->
        Meta.increment_visit_count(response.body["data"])
        conn |> render("reddit_guidelines.html", item: response.body["data"], page_type: page_type)
      {:error, _error} -> 
        render_404_page(conn)
    end
  end

  def everything(conn, _params) do
    page_type = "page"
    client = API.is_localhost(conn.host) |> API.api_client()

    case client |> Page.everything() do
      {:ok, response} ->
        Meta.increment_visit_count(response.body["data"])
        conn |> render("everything.html", item: response.body["data"], page_type: page_type)
      {:error, _error} -> 
        render_404_page(conn)
    end
  end

  def coaching(conn, _params) do
    page_type = "page"
    client = API.is_localhost(conn.host) |> API.api_client()

    case client |> Page.coaching() do
      {:ok, response} ->
        Meta.increment_visit_count(response.body["data"])
        conn |> render("coaching.html", item: response.body["data"], page_type: page_type)
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
        conn |> render("post_relapse_academy.html", layout: {NfdWeb.LayoutView, "home.html"}, item: response.body["data"], page_type: page_type)
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
        conn |> render("emergency.html", layout: {NfdWeb.LayoutView, "home.html"}, item: response.body["data"], page_type: page_type)
      {:error, _error} -> 
        render_404_page(conn)
    end
  end

  def neverfap_deluxe_league(conn, _params) do
    page_type = "page"
    client = API.is_localhost(conn.host) |> API.api_client()

    case client |> Page.neverfap_deluxe_league() do
      {:ok, response} ->
        Meta.increment_visit_count(response.body["data"])
        conn |> render("neverfap_deluxe_league.html", item: response.body["data"], page_type: page_type)
      {:error, _error} -> 
        render_404_page(conn)
    end
  end

  def helpful_neverfappers_academy(conn, _params) do
    page_type = "page"
    client = API.is_localhost(conn.host) |> API.api_client()

    case client |> Page.helpful_neverfappers_academy() do
      {:ok, response} ->
        Meta.increment_visit_count(response.body["data"])
        conn |> render("helpful_neverfappers_academy.html", item: response.body["data"], page_type: page_type)
      {:error, _error} -> 
        render_404_page(conn)
    end
  end

  def summary(conn, _params) do
    page_type = "page"
    client = API.is_localhost(conn.host) |> API.api_client()

    case client |> Page.summary() do
      {:ok, response} ->
        Meta.increment_visit_count(response.body["data"])
        conn |> render("summary.html", item: response.body["data"], page_type: page_type)
      {:error, _error} -> 
        render_404_page(conn)
    end
  end

  def test(conn, _params) do
    conn |> render("test.html")
  end

  def final(conn, _params) do
    conn |> render("final.html")
  end

  def apple_podcast_xml(conn, _params) do 
    client = API.is_localhost(conn.host) |> API.api_client()

    case Tesla.get(client, "http://rss.castbox.fm/everest/aab82e46f0cd4791b1c8ddc19d5158c3.xml") do
      {:ok, response} ->
        regex = ~r/https:\/\/s3.castbox.fm(\/*[a-zA-Z0-9])*.png/
        # does_match = Regex.match?(regex, "https://s3.castbox.fm/89/8f/d7/ab55544abb81506d8240808921.png") |> IO.inspect 
        
        new_xml = Regex.replace(regex, response.body, "https://neverfapdeluxe.com/images/logo_podcast.png", global: true)

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
