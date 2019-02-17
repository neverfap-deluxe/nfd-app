defmodule NfdWeb.PageController do
  use NfdWeb, :controller

  plug :put_layout, "hub.html"

  def dashboard(conn, _params) do
    render(conn, "dashboard.html")
  end

  def profile(conn, _params) do
    render(conn, "profile.html")
  end

end
