defmodule NfdWeb.DashboardController do
  use NfdWeb, :controller

  alias Nfd.Content

  plug :put_layout, "hub.html"

  def dashboard(conn, _params) do
    conn
      |> put_flash(:info, "Welcome back!")
      |> render("dashboard.html")
  end

  # audio courses
  def audio_courses(conn, _params) do
    collections = Content.list_audio_courses()
    render(conn, "audio_courses.html", collections: collections)
  end

  def audio_courses_collection(conn, %{"collection" => collection}) do
    collections = Content.list_audio_courses()
    collection = Content.get_collection_slug(collection)
    render(conn, "audio_courses_collection.html", collections: collections, collection: collection)
  end

  def audio_courses_file(conn, %{"collection" => collection, "file" => file}) do
    collections = Content.list_audio_courses()
    collection = Content.get_collection_slug(collection)
    file = Content.get_file_slug(file)
    render(conn, "audio_courses_file.html", collections: collections, collection: collection, file: file)
  end

  # email challenges
  def email_campaigns(conn, _params) do
    collections = Content.list_email_campaigns()
    render(conn, "email_campaigns.html", collections: collections)
  end

  def email_campaigns_collection(conn, %{"collection" => collection}) do
    collections = Content.list_email_campaigns()
    collection = Content.get_collection_slug(collection)
    render(conn, "email_campaigns_collection.html", collections: collections, collection: collection)
  end

  def email_campaigns_file(conn, %{"collection" => collection, "file" => file}) do
    collections = Content.list_email_campaigns()
    collection = Content.get_collection_slug(collection)
    file = Content.get_file_slug(file)
    render(conn, "email_campaigns_file.html", collections: collections, collection: collection, file: file)
  end

  def profile(conn, _params) do
    render(conn, "profile.html")
  end

  def profile_delete_confirmation(conn, _params) do
    render(conn, "profile.html")
  end

end
