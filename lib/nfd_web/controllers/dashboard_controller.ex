defmodule NfdWeb.DashboardController do
  use NfdWeb, :controller

  alias NfdWeb.FetchDashboard
  alias NfdWeb.FetchCollection

  def dashboard(conn, _params), do: FetchDashboard.fetch_dashboard(conn, :dashboard, "", "", FetchCollection.fetch_collections_array(:dashboard))
  def dashboard_coaching(conn, _params), do: FetchDashboard.fetch_dashboard(conn, :dashboard_coaching, "", "", FetchCollection.fetch_collections_array(:dashboard_coaching))

  def courses(conn, _params), do: FetchDashboard.fetch_dashboard(conn, :courses, "", "", FetchCollection.fetch_collections_array(:courses))
  def courses_collection(conn, %{"collection" => collection_slug}), do: FetchDashboard.fetch_dashboard(conn, :courses_collection, collection_slug, "", FetchCollection.fetch_collections_array(:courses_collection))
  def course_file(conn, %{"collection" => collection_slug, "file" => file_slug}), do: FetchDashboard.fetch_dashboard(conn, :course_file, collection_slug, file_slug, FetchCollection.fetch_collections_array(:course_file))

  def ebooks(conn, _params), do: FetchDashboard.fetch_dashboard(conn, :ebooks, "", "", FetchCollection.fetch_collections_array(:ebooks))
  def ebooks_collection(conn, %{"collection" => collection_slug}), do: FetchDashboard.fetch_dashboard(conn, :ebooks_collection, collection_slug, "", FetchCollection.fetch_collections_array(:ebooks_collection))
  def ebook_file(conn, %{"collection" => collection_slug, "file" => file_slug}), do: FetchDashboard.fetch_dashboard(conn, :ebook_file, collection_slug, file_slug, FetchCollection.fetch_collections_array(:ebook_file))

  def profile(conn, _params), do: FetchDashboard.fetch_dashboard(conn, :profile, "", "", FetchCollection.fetch_collections_array(:profile))
  def profile_delete_confirmation(conn, _params), do: FetchDashboard.fetch_dashboard(conn, :profile_delete_confirmation, "", "", FetchCollection.fetch_collections_array(:profile_delete_confirmation))
end
