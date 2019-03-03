defmodule NfdWeb.DashboardController do
  use NfdWeb, :controller

  plug :put_layout, "hub.html"

  def dashboard(conn, _params) do
    conn
      |> put_flash(:info, "Welcome back!")
      |> render("dashboard.html")
  end

  def audio_courses(conn, _params) do
    render(conn, "audio_courses.html")
  end

  def email_challenges(conn, _params) do
    render(conn, "email_challenges.html")
  end

  def profile(conn, _params) do
    render(conn, "profile.html")
  end

  def profile_delete_confirmation(conn, _params) do
    render(conn, "profile.html")
  end

end
