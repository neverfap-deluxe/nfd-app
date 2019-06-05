defmodule NfdWeb.ContentController do
  use NfdWeb, :controller
  
  alias NfdWeb.Fetch

  def articles(conn, _params), do: Fetch.fetch_page(conn, :articles, "general.html", [:articles])  
  def article(conn, %{"slug" => slug}), do: Fetch.fetch_content(conn, :article, slug, "general.html", [:articles, :seven_day_kickstarter, :seven_day_kickstarter_changeset, :comments, :comment_form_changeset])  

  def practices(conn, _params), do: Fetch.fetch_page(conn, :practices, "general.html", [:practices])  
  def practice(conn, %{"slug" => slug}), do: Fetch.fetch_content(conn, :practice, slug, "general.html", [:articles, :practices, :seven_day_kickstarter, :seven_day_kickstarter_changeset, :comments, :comment_form_changeset])  

  def courses(conn, _params), do: Fetch.fetch_page(conn, :courses, "general.html", [:courses])  
  def course(conn, %{"slug" => slug}), do: Fetch.fetch_content(conn, :course, slug, "general.html", [:articles, :practices])  

  def podcasts(conn, _params), do: Fetch.fetch_page(conn, :podcasts, "general.html", [:podcasts])  
  def podcast(conn, %{"slug" => slug}), do: Fetch.fetch_content(conn, :podcast, slug, "general.html", [:podcasts])  

  def quotes(conn, _params), do: Fetch.fetch_page(conn, :quotes, "general.html", [:quotes])  
  def quote(conn, %{"slug" => slug}), do: Fetch.fetch_content(conn, :quote, slug, "general.html", [:quotes])  

  def meditations(conn, _params), do: Fetch.fetch_page(conn, :meditations, "general.html", [:meditations])  
  def meditation(conn, %{"slug" => slug}), do: Fetch.fetch_content(conn, :meditation, slug, "general.html", [:meditations])  

  def blogs(conn, _params), do: Fetch.fetch_page(conn, :blogs, "general.html", [:blogs])  
  def blog(conn, %{"slug" => slug}), do: Fetch.fetch_content(conn, :blog, slug, "general.html", [:blogs])  

  def updates(conn, _params), do: Fetch.fetch_page(conn, :updates, "general.html", [:updates])  
  def update(conn, %{"slug" => slug}), do: Fetch.fetch_content(conn, :update, slug, "general.html", [:updates])  
end
