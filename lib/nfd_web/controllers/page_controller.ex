defmodule NfdWeb.PageController do
  use NfdWeb, :controller

  def index(conn, _params) do

    changeset = Pow.Plug.change_user(conn)

    render(conn, "index.html", changeset: changeset)
  end
end
