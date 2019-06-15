defmodule NfdWeb.Fetch do
  use NfdWeb, :controller

  alias Nfd.Meta
  alias Nfd.Meta.Comment

  alias Nfd.API
  alias Nfd.API.Page
  alias Nfd.API.Content

  alias Nfd.Account.Subscriber
  alias Nfd.Account.ContactForm

  alias NfdWeb.Redirects

  def fetch_content(conn, page_view, page_symbol, slug, page_layout, collection_array) do
    client = API.is_localhost(conn.host) |> API.api_client()
    verified_slug = Redirects.redirect_content(conn, slug, Atom.to_string(page_symbol))

    case apply(Content, page_symbol, [client, verified_slug]) do
      {:ok, response} ->
        collections = fetch_collections(response.body["data"], collection_array, client)
        fetch_response_ok(conn, page_view, response, collections, page_symbol, page_layout, "content")
      {:error, error} ->
        render_404_page(conn, error)
    end
  end

  def fetch_page(conn, page_view, page_symbol, page_layout, collection_array) do
    page_type = "page"
    client = API.is_localhost(conn.host) |> API.api_client()
    case apply(Page, page_symbol, [client]) do
      {:ok, response} ->
        collections = fetch_collections(response.body["data"], collection_array, client)
        fetch_response_ok(conn, page_view, response, collections, page_symbol, page_layout, page_type)
      {:error, error} -> render_404_page(conn, error)
    end
  end

  def fetch_response_ok(conn, page_view, response, collections, page_symbol, page_layout, page_type) do
    check_api_response_for_404(conn, response.status)
    Meta.increment_visit_count(response.body["data"])
    conn |> put_view(page_view) |> render("#{Atom.to_string(page_symbol)}.html", layout: { NfdWeb.LayoutView, page_layout }, item: response.body["data"], collections: collections, page_type: page_type)
  end

  def fetch_collections(item, collection_array, client) do
    Enum.reduce(
      collection_array,
      %{},
      fn x, acc ->
        case x do
          # COLLECTIONS
          :articles -> merge_collection(client, :articles, acc, item)
          :practices -> merge_collection(client, :practices, acc, item)
          :quotes -> merge_collection(client, :quotes, acc, item)
          :updates -> merge_collection(client, :updates, acc, item)
          :blogs -> merge_collection(client, :blogs, acc, item)
          :podcasts -> merge_collection(client, :podcasts, acc, item)
          :meditations -> merge_collection(client, :meditations, acc, item)
          :courses -> merge_collection(client, :courses, acc, item)

          :comments ->
            comments = Meta.list_collection_access_by_page_id(item["page_id"]) |> Comment.organise_comments()
            Map.put(acc, :comments, comments)

          # MESSAGE CHANGESETS
          :contact_form_changeset ->
            contact_form_changeset = ContactForm.changeset(%ContactForm{}, %{name: "", email: "", message: ""})
            Map.put(acc, :contact_form_changeset, contact_form_changeset)

          :comment_form_changeset ->
<<<<<<< HEAD
            comment_form_changeset = Comment.changeset(%Comment{}, %{name: "", email: "", message: "", page_id: "", depth: 0})
=======
            comment_form_changeset = Comment.changeset(%Comment{}, %{name: "", email: "", message: "", parent_message_id: "", depth: 0, page_id: item["page_id"]})
>>>>>>> production
            Map.put(acc, :comment_form_changeset, comment_form_changeset)

          # CONTENT EMAIL
          :seven_day_kickstarter ->
            {:ok, sdkResponse} = client |> Page.seven_day_kickstarter()
            seven_day_kickstarter = sdkResponse.body["data"]
            Map.put(acc, :seven_day_kickstarter, seven_day_kickstarter)

          :seven_day_kickstarter_changeset -> Map.put(acc, :seven_day_kickstarter_changeset, Subscriber.changeset(%Subscriber{}, %{}))
          :ten_day_meditation_changeset -> Map.put(acc, :ten_day_meditation_changeset, Subscriber.changeset(%Subscriber{}, %{}))
          :twenty_eight_day_awareness_changeset -> Map.put(acc, :twenty_eight_day_awareness_changeset, Subscriber.changeset(%Subscriber{}, %{}))
            
          _ ->
            acc
        end
      end)
  end

  defp merge_collection(client, content_symbol, acc, item) do
    {:ok, response} = apply(Page, content_symbol, [client])
    collections = response.body["data"][Atom.to_string(content_symbol)] |> Enum.reverse()
    { previous_item, next_item } = Nfd.Meta.Page.previous_next_item(collections, item);
    Map.merge(acc, %{
      content_symbol => collections,
      next_item: next_item,
      previous_item: previous_item
    })
  end

  def render_404_page(conn, error) do
    IO.inspect error
    conn
      |> put_view(NfdWeb.ErrorView)
      |> render("404.html")
  end

  defp check_api_response_for_404(conn, status) do
    if status != 200, do: render_404_page(conn, status)
  end
end
