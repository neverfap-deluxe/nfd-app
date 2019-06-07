defmodule NfdWeb.ContentController do
  use NfdWeb, :controller

  alias NfdWeb.Fetch
  alias NfdWeb.FetchCollection

  def articles(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.ContentView, :articles, "general.html", FetchCollection.fetch_collections_array(:articles))
  def article(conn, %{"slug" => slug}), do: Fetch.fetch_content(conn, NfdWeb.ContentView, :article, slug, "general.html", FetchCollection.fetch_collections_array(:article))

  def practices(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.ContentView, :practices, "general.html", FetchCollection.fetch_collections_array(:practices))
  def practice(conn, %{"slug" => slug}), do: Fetch.fetch_content(conn, NfdWeb.ContentView, :practice, slug, "general.html", FetchCollection.fetch_collections_array(:practice))

  def courses(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.ContentView, :courses, "general.html", FetchCollection.fetch_collections_array(:courses))
  def course(conn, %{"slug" => slug}), do: Fetch.fetch_content(conn, NfdWeb.ContentView, :course, slug, "general.html", FetchCollection.fetch_collections_array(:course))

  def podcasts(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.ContentView, :podcasts, "general.html", FetchCollection.fetch_collections_array(:podcasts))
  def podcast(conn, %{"slug" => slug}), do: Fetch.fetch_content(conn, NfdWeb.ContentView, :podcast, slug, "general.html", FetchCollection.fetch_collections_array(:podcast))

  def quotes(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.ContentView, :quotes, "general.html", FetchCollection.fetch_collections_array(:quotes))
  def quote(conn, %{"slug" => slug}), do: Fetch.fetch_content(conn, NfdWeb.ContentView, :quote, slug, "general.html", FetchCollection.fetch_collections_array(:quote))

  def meditations(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.ContentView, :meditations, "general.html", FetchCollection.fetch_collections_array(:meditations))
  def meditation(conn, %{"slug" => slug}), do: Fetch.fetch_content(conn, NfdWeb.ContentView, :meditation, slug, "general.html", FetchCollection.fetch_collections_array(:meditation))

  def blogs(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.ContentView, :blogs, "general.html", FetchCollection.fetch_collections_array(:blogs))
  def blog(conn, %{"slug" => slug}), do: Fetch.fetch_content(conn, NfdWeb.ContentView, :blog, slug, "general.html", FetchCollection.fetch_collections_array(:blog))

  def updates(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.ContentView, :updates, "general.html", FetchCollection.fetch_collections_array(:updates))
  def update(conn, %{"slug" => slug}), do: Fetch.fetch_content(conn, NfdWeb.ContentView, :update, slug, "general.html", FetchCollection.fetch_collections_array(:update))
end
