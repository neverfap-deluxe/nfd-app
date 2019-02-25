defmodule NfdWeb.DashboardController do
  use NfdWeb, :controller

  plug :put_layout, "hub.html"

  def dashboard(conn, _params) do
    current_user = Pow.Plug.current_user(conn)

    if (current_user.unconfirmed_email) do
      conn
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: Routes.dashboard_path(conn, :dashboard))  
    else 
      conn
        |> put_flash(:user_email, current_user.email)
        |> redirect(to: Routes.registration_path(conn, :confirm_email_begin))
    end

  end

  def profile(conn, _params) do
    render(conn, "profile.html")
  end

  def profile_delete_confirmation(conn, _params) do
    render(conn, "profile.html")
  end
end
