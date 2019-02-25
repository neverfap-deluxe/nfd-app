defmodule NfdWeb.AuthErrorHandler do
  use NfdWeb, :controller
  alias Plug.Conn

  @spec call(Conn.t(), atom()) :: Conn.t()
  def call(conn, :not_authenticated) do
    conn
    |> put_flash(:error, "You've to be authenticated first")
    |> redirect(to: Routes.registration_path(conn, :account))
  end

  @spec call(Conn.t(), atom()) :: Conn.t()
  def call(conn, :already_authenticated) do

    current_user = Pow.Plug.current_user(conn)

    IO.inspect(current_user.unconfirmed_email)

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
end

