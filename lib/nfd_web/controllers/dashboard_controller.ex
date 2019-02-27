defmodule NfdWeb.DashboardController do
  use NfdWeb, :controller

  plug :put_layout, "hub.html"

  def dashboard(conn, _params) do
    conn
      |> put_flash(:info, "Welcome back!")
      |> redirect(to: Routes.dashboard_path(conn, :dashboard))  

  end

  def profile(conn, _params) do
    render(conn, "profile.html")
  end

  def profile_delete_confirmation(conn, _params) do
    render(conn, "profile.html")
  end
end
