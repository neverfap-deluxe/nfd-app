defmodule NfdWeb.PageController do
  use NfdWeb, :controller

  def hub(conn, _params) do
    render(conn, "hub.html")
  end

end
