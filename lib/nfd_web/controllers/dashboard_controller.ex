defmodule NfdWeb.DashboardController do
  use NfdWeb, :controller

  alias NfdWeb.Fetch
  alias NfdWeb.FetchAccess

  def dashboard(conn, _params), do: Fetch.fetch_dashboard(conn, :dashboard, "", "", FetchAccess.fetch_access_array(:dashboard))
  def dashboard_coaching(conn, _params), do: Fetch.fetch_dashboard(conn, :dashboard_coaching, "", "", FetchAccess.fetch_access_array(:dashboard_coaching))

  def dashboard_courses(conn, _params), do: Fetch.fetch_dashboard(conn, :dashboard_courses, "", "", FetchAccess.fetch_access_array(:dashboard_courses))
  def dashboard_course_collection(conn, %{"collection" => collection_slug}), do: Fetch.fetch_dashboard(conn, :dashboard_course_collection, collection_slug, "", FetchAccess.fetch_access_array(:dashboard_course_collection))
  def dashboard_course_file(conn, %{"collection" => collection_slug, "file" => file_slug}), do: Fetch.fetch_dashboard(conn, :dashboard_course_file, collection_slug, file_slug, FetchAccess.fetch_access_array(:dashboard_course_file))

  def dashboard_ebooks(conn, _params), do: Fetch.fetch_dashboard(conn, :dashboard_ebooks, "", "", FetchAccess.fetch_access_array(:dashboard_ebooks))
  def dashboard_ebook_collection(conn, %{"collection" => collection_slug}), do: Fetch.fetch_dashboard(conn, :dashboard_ebook_collection, collection_slug, "", FetchAccess.fetch_access_array(:dashboard_ebook_collection))
  def dashboard_ebook_file(conn, %{"collection" => collection_slug, "file" => file_slug}), do: Fetch.fetch_dashboard(conn, :dashboard_ebook_file, collection_slug, file_slug, FetchAccess.fetch_access_array(:dashboard_ebook_file))

  def dashboard_profile(conn, _params), do: Fetch.fetch_dashboard(conn, :dashboard_profile, "", "", FetchAccess.fetch_access_array(:dashboard_profile))
  def dashboard_profile_delete_confirmation(conn, _params), do: Fetch.fetch_dashboard(conn, :dashboard_profile_delete_confirmation, "", "", FetchAccess.fetch_access_array(:dashboard_profile_delete_confirmation))
end
