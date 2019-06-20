defmodule NfdWeb.ContentController do
  use NfdWeb, :controller

  alias NfdWeb.Fetch
  alias NfdWeb.FetchAccess

  def articles(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.ContentView, :articles, "general.html", FetchCollection.fetch_access_array(:articles))
  def article(conn, %{"slug" => slug}), do: Fetch.fetch_content(conn, NfdWeb.ContentView, :article, slug, "general.html", FetchCollection.fetch_access_array(:article))

  def practices(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.ContentView, :practices, "general.html", FetchCollection.fetch_access_array(:practices))
  def practice(conn, %{"slug" => slug}), do: Fetch.fetch_content(conn, NfdWeb.ContentView, :practice, slug, "general.html", FetchCollection.fetch_access_array(:practice))

  def courses(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.ContentView, :courses, "general.html", FetchCollection.fetch_access_array(:courses))
  def course(conn, %{"slug" => slug}), do: Fetch.fetch_content(conn, NfdWeb.ContentView, :course, slug, "general.html", FetchCollection.fetch_access_array(:course))

  def podcasts(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.ContentView, :podcasts, "general.html", FetchCollection.fetch_access_array(:podcasts))
  def podcast(conn, %{"slug" => slug}), do: Fetch.fetch_content(conn, NfdWeb.ContentView, :podcast, slug, "general.html", FetchCollection.fetch_access_array(:podcast))

  def quotes(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.ContentView, :quotes, "general.html", FetchCollection.fetch_access_array(:quotes))
  def quote(conn, %{"slug" => slug}), do: Fetch.fetch_content(conn, NfdWeb.ContentView, :quote, slug, "general.html", FetchCollection.fetch_access_array(:quote))

  def meditations(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.ContentView, :meditations, "general.html", FetchCollection.fetch_access_array(:meditations))
  def meditation(conn, %{"slug" => slug}), do: Fetch.fetch_content(conn, NfdWeb.ContentView, :meditation, slug, "general.html", FetchCollection.fetch_access_array(:meditation))

  def blogs(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.ContentView, :blogs, "general.html", FetchCollection.fetch_access_array(:blogs))
  def blog(conn, %{"slug" => slug}), do: Fetch.fetch_content(conn, NfdWeb.ContentView, :blog, slug, "general.html", FetchCollection.fetch_access_array(:blog))

  def updates(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.ContentView, :updates, "general.html", FetchCollection.fetch_access_array(:updates))
  def update(conn, %{"slug" => slug}), do: Fetch.fetch_content(conn, NfdWeb.ContentView, :update, slug, "general.html", FetchCollection.fetch_access_array(:update))
end
