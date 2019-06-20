defmodule NfdWeb.DashboardController do
  use NfdWeb, :controller

  alias NfdWeb.FetchDashboard
  alias NfdWeb.FetchAccess

  def dashboard(conn, _params), do: FetchDashboard.fetch_dashboard(conn, :dashboard, "", "", FetchCollection.fetch_access_array(:dashboard))
  def dashboard_coaching(conn, _params), do: FetchDashboard.fetch_dashboard(conn, :dashboard_coaching, "", "", FetchCollection.fetch_access_array(:dashboard_coaching))

  def courses(conn, _params), do: FetchDashboard.fetch_dashboard(conn, :courses, "", "", FetchCollection.fetch_access_array(:courses))
  def course_collection(conn, %{"collection" => collection_slug}), do: FetchDashboard.fetch_dashboard(conn, :course_collection, collection_slug, "", FetchCollection.fetch_access_array(:course_collection))
  def course_file(conn, %{"collection" => collection_slug, "file" => file_slug}), do: FetchDashboard.fetch_dashboard(conn, :course_file, collection_slug, file_slug, FetchCollection.fetch_access_array(:course_file))

  def ebooks(conn, _params), do: FetchDashboard.fetch_dashboard(conn, :ebooks, "", "", FetchCollection.fetch_access_array(:ebooks))
  def ebooks_collection(conn, %{"collection" => collection_slug}), do: FetchDashboard.fetch_dashboard(conn, :ebooks_collection, collection_slug, "", FetchCollection.fetch_access_array(:ebooks_collection))
  def ebook_file(conn, %{"collection" => collection_slug, "file" => file_slug}), do: FetchDashboard.fetch_dashboard(conn, :ebook_file, collection_slug, file_slug, FetchCollection.fetch_access_array(:ebook_file))

  def profile(conn, _params), do: FetchDashboard.fetch_dashboard(conn, :profile, "", "", FetchCollection.fetch_access_array(:profile))
  def profile_delete_confirmation(conn, _params), do: FetchDashboard.fetch_dashboard(conn, :profile_delete_confirmation, "", "", FetchCollection.fetch_access_array(:profile_delete_confirmation))
end
