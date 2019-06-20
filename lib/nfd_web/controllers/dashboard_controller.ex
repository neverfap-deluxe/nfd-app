defmodule NfdWeb.DashboardController do
  use NfdWeb, :controller

  alias NfdWeb.Fetch
  alias NfdWeb.FetchAccess

  def dashboard(conn, _params), do: Fetch.fetch_dashboard(conn, :dashboard, "", "", FetchAccess.fetch_access_array(:dashboard))
  def dashboard_coaching(conn, _params), do: Fetch.fetch_dashboard(conn, :dashboard_coaching, "", "", FetchAccess.fetch_access_array(:dashboard_coaching))

  def courses(conn, _params), do: Fetch.fetch_dashboard(conn, :courses, "", "", FetchAccess.fetch_access_array(:courses))
  def course_collection(conn, %{"collection" => collection_slug}), do: Fetch.fetch_dashboard(conn, :course_collection, collection_slug, "", FetchAccess.fetch_access_array(:course_collection))
  def course_file(conn, %{"collection" => collection_slug, "file" => file_slug}), do: Fetch.fetch_dashboard(conn, :course_file, collection_slug, file_slug, FetchAccess.fetch_access_array(:course_file))

  def ebooks(conn, _params), do: Fetch.fetch_dashboard(conn, :ebooks, "", "", FetchAccess.fetch_access_array(:ebooks))
  def ebook_collection(conn, %{"collection" => collection_slug}), do: Fetch.fetch_dashboard(conn, :ebook_collection, collection_slug, "", FetchAccess.fetch_access_array(:ebook_collection))
  def ebook_file(conn, %{"collection" => collection_slug, "file" => file_slug}), do: Fetch.fetch_dashboard(conn, :ebook_file, collection_slug, file_slug, FetchAccess.fetch_access_array(:ebook_file))

  def profile(conn, _params), do: Fetch.fetch_dashboard(conn, :profile, "", "", FetchAccess.fetch_access_array(:profile))
  def profile_delete_confirmation(conn, _params), do: Fetch.fetch_dashboard(conn, :profile_delete_confirmation, "", "", FetchAccess.fetch_access_array(:profile_delete_confirmation))
end
