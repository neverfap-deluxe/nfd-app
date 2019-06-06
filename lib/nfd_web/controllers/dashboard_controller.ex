defmodule NfdWeb.DashboardController do
  use NfdWeb, :controller

  alias NfdWeb.FetchDashboard

  def dashboard(conn, _params), do: FetchDashboard.fetch_dashboard(conn, :dashboard, "", "", [:collections_email])
  def dashboard_coaching(conn, _params), do: FetchDashboard.fetch_dashboard(conn, :dashboard_coaching, "", "", [:collections_email])

  def email_campaigns(conn, _params), do: FetchDashboard.fetch_dashboard(conn, :email_campaigns, "", "", [:collections_email])
  def email_campaigns_collection(conn, %{"collection" => collection_slug}), do: FetchDashboard.fetch_dashboard(conn, :email_campaigns_collection, collection_slug, "", [:collection_email, :collections_email, :stripe_api_key])
  def email_campaigns_file(conn, %{"collection" => collection_slug, "file" => file_slug}), do: FetchDashboard.fetch_dashboard(conn, :email_campaigns_file, collection_slug, file_slug, [:collection_email, :collections_email, :collections_email_file, :stripe_api_key])

  def audio_campaigns(conn, _params), do: FetchDashboard.fetch_dashboard(conn, :audio_campaigns, "", "", [:collections_audio])
  def audio_campaigns_collection(conn, %{"collection" => collection_slug}), do: FetchDashboard.fetch_dashboard(conn, :audio_campaigns_collection, collection_slug, "", [:collection_audio, :collections_audio, :stripe_api_key])
  def audio_campaigns_file(conn, %{"collection" => collection_slug, "file" => file_slug}), do: FetchDashboard.fetch_dashboard(conn, :audio_campaigns_file, collection_slug, file_slug, [:collection_audio, :collections_audio, :collections_audio_file, :stripe_api_key])

  def profile(conn, _params), do: FetchDashboard.fetch_dashboard(conn, :profile, "", "", [])
  def profile_delete_confirmation(conn, _params), do: FetchDashboard.fetch_dashboard(conn, :profile_delete_confirmation, "", "", [])
end
