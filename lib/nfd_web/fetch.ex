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

  def fetch_content(conn, page_symbol, slug, page_layout, collection_array) do
    client = API.is_localhost(conn.host) |> API.api_client()
    verified_slug = Redirects.redirect_content(conn, slug, Atom.to_string(page_symbol))

    case apply(Content, page_symbol, [client, verified_slug]) do
      {:ok, response} ->
        collections = fetch_collections(response.body["data"], collection_array, client)
        fetch_response_ok(conn, response, collections, page_symbol, page_layout, "content")
      {:error, error} ->
        render_404_page(conn, error)
    end
  end

  def fetch_page(conn, page_symbol, page_layout, collection_array) do
    page_type = "page"
    client = API.is_localhost(conn.host) |> API.api_client()
    case apply(Page, page_symbol, [client]) do
      {:ok, response} ->
        collections = fetch_collections(response.body["data"], collection_array, client)
        fetch_response_ok(conn, response, collections, page_symbol, page_layout, page_type)
      {:error, error} -> render_404_page(conn, error)
    end
  end

  def fetch_response_ok(conn, response, collections, page_symbol, page_layout, page_type) do
    check_api_response_for_404(conn, response.status)
    Meta.increment_visit_count(response.body["data"])
    conn |> render("#{Atom.to_string(page_symbol)}.html", layout: { NfdWeb.LayoutView, page_layout }, item: response.body["data"], collections: collections, page_type: page_type)
  end

  def fetch_collections(item, collection_array, client) do
    Enum.reduce(
      collection_array,
      %{},
      fn x, acc ->
        case x do
          # COLLECTIONS
          :articles ->
            merge_collection(client, :articles, acc, item)

          :practices ->
            merge_collection(client, :practices, acc, item)

          :quotes ->
            merge_collection(client, :quotes, acc, item)

          :updates ->
            merge_collection(client, :updates, acc, item)

          :blogs ->
            merge_collection(client, :blogs, acc, item)

          :podcasts ->
            merge_collection(client, :podcasts, acc, item)

          :meditations ->
            merge_collection(client, :meditations, acc, item)

          :courses ->
            merge_collection(client, :courses, acc, item)

          # CONTENT EMAIL
          :seven_day_kickstarter ->
            {:ok, sdkResponse} = client |> Page.seven_day_kickstarter()
            seven_day_kickstarter = sdkResponse.body["data"]
            Map.put(acc, :seven_day_kickstarter, seven_day_kickstarter)

          :comments ->
            comments = Meta.list_collection_access_by_page_id(item["page_id"]) |> organise_comments()
            Map.put(acc, :comments, comments)

          # CHANGESETS
          :contact_form_changeset ->
            contact_form_changeset = ContactForm.changeset(%ContactForm{}, %{name: "", email: "", message: ""})
            Map.put(acc, :contact_form_changeset, contact_form_changeset)

          :comment_form_changeset ->
            comment_form_changeset = Comment.changeset(%Comment{}, %{name: "", email: "", message: ""})
            Map.put(acc, :comment_form_changeset, comment_form_changeset)

          :seven_day_kickstarter_changeset ->
            seven_day_kickstarter_changeset = Subscriber.changeset(%Subscriber{}, %{})
            Map.put(acc, :seven_day_kickstarter_changeset, seven_day_kickstarter_changeset)

          _ ->
            acc
        end
      end)
  end

  def merge_collection(client, content_symbol, acc, item) do
    {:ok, response} = apply(Page, content_symbol, [client])
    collections = response.body["data"][Atom.to_string(content_symbol)] |> Enum.reverse()
    { previous_item, next_item } = previous_next_item(collections, item);
    Map.merge(acc, %{
      content_symbol => collections,
      next_item: next_item,
      previous_item: previous_item
    })
  end

  def organise_comments(comments) do
    comments
      |> Enum.filter(fn (comment) -> !comment.parent_message_id end)
      |> Enum.reduce(
        %{parents: []},
        fn reduce_comment, acc ->
          children_comments = recursive_find_comments(comments, reduce_comment, acc)
          %{parents: acc.parents ++ Map.put(reduce_comment, :children, children_comments)}
        end)
      |> IO.inspect comments
  end

  def recursive_find_comments(comments, reduce_comment, acc) do 
    # Find the children of the comment
    reduce_comment_children = Enum.filter(comments, fn (filter_comment) -> filter_comment.parent_message_id == reduce_comment.id end)
    
    # if children then add them to current comment
    if reduce_comment_children do 
      reduce_comment_children
        |> Enum.map(fn (comment_child) -> 
          new_comment_child = Map.put(reduce_comment, :children, reduce_comment_children)
          recursive_find_comments(comments, new_comment_child, acc) 
        end)
    # if not children, then just pass back to the
    else
      %{child: reduce_comment}
    end
  end

  def previous_next_item(articles, current_article) do
    article_values =
      Enum.reduce(articles, %{last: nil, values: [], correct: false, previous_item: nil, next_item: nil}, fn article, acc ->
        if acc.correct do
          %{last: article, previous_item: acc.previous_item, next_item: article, correct: false }
        else
          if current_article["slug"] == article["slug"] do
            %{last: article, previous_item: acc.last, next_item: nil, correct: true }
          else
            %{last: article, previous_item: acc.previous_item, next_item: acc.next_item, correct: false}
          end
        end
      end)

    { article_values.previous_item, article_values.next_item }
  end

  def render_404_page(conn, error) do
    IO.inspect error
    conn
      |> put_view(NfdWeb.ErrorView)
      |> render("404.html")
  end

  def check_api_response_for_404(conn, status) do
    if status != 200, do: render_404_page(conn, status)
  end
end
