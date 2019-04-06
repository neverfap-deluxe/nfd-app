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

  defp render_404_page(conn) do 
    conn 
      |> put_view(NfdWeb.ErrorView)
      |> render("404.html")
  end
end
