defmodule NfdWeb.PageController do
  use NfdWeb, :controller

  def index(conn, _params) do
    render(conn, "hub.html")
      # |> redirect(to: Routes.page_path(conn, :hub))
  end

  def hub(conn, _params) do
    render(conn, "hub.html")
  end

end
