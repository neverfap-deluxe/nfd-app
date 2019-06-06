defmodule NfdWeb.DashboardController do
  use NfdWeb, :controller

  alias NfdWeb.FetchDashboard
  alias NfdWeb.FetchCollection

  def dashboard(conn, _params), do: FetchDashboard.fetch_dashboard(conn, :dashboard, "", "", FetchCollection.fetch_collections_array(:dashboard))
  def dashboard_coaching(conn, _params), do: FetchDashboard.fetch_dashboard(conn, :dashboard_coaching, "", "", FetchCollection.fetch_collections_array(:dashboard_coaching))

  def email_campaigns(conn, _params), do: FetchDashboard.fetch_dashboard(conn, :email_campaigns, "", "", FetchCollection.fetch_collections_array(:email_campaigns))
  def email_campaigns_collection(conn, %{"collection" => collection_slug}), do: FetchDashboard.fetch_dashboard(conn, :email_campaigns_collection, collection_slug, "", FetchCollection.fetch_collections_array(:email_campaigns_collection))
  def email_campaigns_file(conn, %{"collection" => collection_slug, "file" => file_slug}), do: FetchDashboard.fetch_dashboard(conn, :email_campaigns_file, collection_slug, file_slug, FetchCollection.fetch_collections_array(:email_campaigns_file))

  def audio_courses(conn, _params), do: FetchDashboard.fetch_dashboard(conn, :audio_courses, "", "", FetchCollection.fetch_collections_array(:audio_courses))
  def audio_courses_collection(conn, %{"collection" => collection_slug}), do: FetchDashboard.fetch_dashboard(conn, :audio_courses_collection, collection_slug, "", FetchCollection.fetch_collections_array(:audio_courses_collection))
  def audio_courses_file(conn, %{"collection" => collection_slug, "file" => file_slug}), do: FetchDashboard.fetch_dashboard(conn, :audio_courses_file, collection_slug, file_slug, FetchCollection.fetch_collections_array(:audio_courses_file))

  def profile(conn, _params), do: FetchDashboard.fetch_dashboard(conn, :profile, "", "", FetchCollection.fetch_collections_array(:profile))
  def profile_delete_confirmation(conn, _params), do: FetchDashboard.fetch_dashboard(conn, :profile_delete_confirmation, "", "", FetchCollection.fetch_collections_array(:profile_delete_confirmation))
end
