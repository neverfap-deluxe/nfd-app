defmodule NfdWeb.PageController do
  use NfdWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
