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
    page_type = "content"
    client = API.is_localhost(conn.host) |> API.api_client()
    verified_slug = Redirects.redirect(conn, slug, Atom.to_string(page_symbol))

    case apply(Content, page_symbol, [client, verified_slug]) do
      {:ok, response} ->
        item = response.body["data"]
        check_api_response_for_404(conn, response.status)
        Meta.increment_visit_count(item)
        if response.body["data"]["draft"] == false do 
          collections = fetch_collections(item, collection_array, client)
          conn |> render("#{Atom.to_string(page_symbol)}.html", layout: { NfdWeb.LayoutView, page_layout }, item: item, collections: collections, page_type: page_type)
        else 
          render_404_page(conn)
        end
      {:error, error} ->
        IO.inspect error
        render_404_page(conn)
    end
  end

  def fetch_page(conn, page_symbol, page_layout, collection_array) do
    page_type = "page"
    client = API.is_localhost(conn.host) |> API.api_client()
    case apply(Page, page_symbol, [client]) do
      {:ok, response} ->
        item = response.body["data"]
        Meta.increment_visit_count(item)
        collections = fetch_collections(item, collection_array, client)
        conn |> render("#{Atom.to_string(page_symbol)}.html", layout: { NfdWeb.LayoutView, page_layout }, item: item, collections: collections, page_type: page_type)
      {:error, _error} ->
        render_404_page(conn)
    end
  end


  defp fetch_collections(item, collection_array, client) do
    Enum.reduce(
      collection_array,
      %{},
      fn x, acc ->
        case x do
          # COLLECTIONS
          :articles ->
            {:ok, articlesResponse} = client |> Page.articles()
            articles = articlesResponse.body["data"]["articles"] |> Enum.reverse()
            { previousItem, nextItem } = getPreviousnextItem(articles, item);
            Map.merge(acc, %{
              nextItem: nextItem,
              previousItem: previousItem,
              articles: articles
            })
            
          :practices ->
            {:ok, practicesResponse} = client |> Page.practices()
            practices = practicesResponse.body["data"]["practices"] |> Enum.reverse()
            { previousItem, nextItem } = getPreviousnextItem(practices, item);
            Map.merge(acc, %{
              nextItem: nextItem,
              previousItem: previousItem,
              practices: practices
            })

          :quotes ->
            {:ok, quotesResponse} = client |> Page.quotes()
            quotes = quotesResponse.body["data"]["quotes"] |> Enum.reverse()
            { previousItem, nextItem } = getPreviousnextItem(quotes, item);
            Map.merge(acc, %{
              nextItem: nextItem,
              previousItem: previousItem,
              quotes: quotes
            })

          :updates ->
            {:ok, updatesResponse} = client |> Page.updates()
            updates = updatesResponse.body["data"]["updates"] |> Enum.reverse()
            { previousItem, nextItem } = getPreviousnextItem(updates, item);
            Map.merge(acc, %{
              nextItem: nextItem,
              previousItem: previousItem,
              updates: updates
            })
  
          :blogs ->
            {:ok, blogsResponse} = client |> Page.blogs()
            blogs = blogsResponse.body["data"]["blogs"] |> Enum.reverse()
            { previousItem, nextItem } = getPreviousnextItem(blogs, item);
            Map.merge(acc, %{
              nextItem: nextItem,
              previousItem: previousItem,
              blogs: blogs
            })
    
          :podcasts ->
            {:ok, podcastsResponse} = client |> Page.podcasts()
            podcasts = podcastsResponse.body["data"]["podcasts"] |> Enum.reverse()
            { previousItem, nextItem } = getPreviousnextItem(podcasts, item);
            Map.merge(acc, %{
              nextItem: nextItem,
              previousItem: previousItem,
              podcasts: podcasts
            })
  
          :meditations ->
            {:ok, meditationsResponse} = client |> Page.meditations()
            meditations = meditationsResponse.body["data"]["meditations"] |> Enum.reverse()
            { previousItem, nextItem } = getPreviousnextItem(meditations, item);
            Map.merge(acc, %{
              nextItem: nextItem,
              previousItem: previousItem,
              meditations: meditations
            })
  
          :courses ->
            {:ok, coursesResponse} = client |> Page.courses()
            courses = coursesResponse.body["data"]["courses"] |> Enum.reverse()
            Map.put(acc, :courses, courses)
  
          # CONTENT EMAIL
          :seven_day_kickstarter ->
            {:ok, sdkResponse} = client |> Page.seven_day_kickstarter()
            sdk_item = sdkResponse.body["data"]
            Map.put(acc, :sdk_item, sdk_item)

          :comments -> 
            comments = Meta.list_collection_access_by_page_id(item["page_id"])
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

  defp getPreviousnextItem(articles, currentArticle) do
    articleValues = 
      Enum.reduce(articles, %{last: nil, values: [], correct: false, previousItem: nil, nextItem: nil}, fn article, acc ->
        if acc.correct do
          %{last: article, previousItem: acc.previousItem, nextItem: article, correct: false }
        else  
          if currentArticle["slug"] == article["slug"] do 
            %{last: article, previousItem: acc.last, nextItem: nil, correct: true }
          else 
            %{last: article, previousItem: acc.previousItem, nextItem: acc.nextItem, correct: false}
          end
        end
      end)
      
    { articleValues.previousItem, articleValues.nextItem }
  end

  defp render_404_page(conn) do 
    conn 
      |> put_view(NfdWeb.ErrorView)
      |> render("404.html")
  end

  defp check_api_response_for_404(conn, status) do
    if status != 200, do: render_404_page(conn)
  end
end