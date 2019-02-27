defmodule NfdWeb.AccountController do
  use NfdWeb, :controller

  plug :put_layout, "general.html"

  def account(conn, _params) do
    changeset = Pow.Plug.change_user(conn)

    render(conn, "account.html", changeset: changeset)
  end

  def confirm_email_begin(conn, _params) do
    current_user = Pow.Plug.current_user(conn)

    conn
      |> put_flash(:user_email, current_user.email)
      |> render("confirm_email_begin.html")
  end
end