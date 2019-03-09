defmodule NfdWeb.AccountController do
  use NfdWeb, :controller

  alias Nfd.Account

  plug :put_layout, "general.html"

  def account(conn, _params) do
    changeset = Pow.Plug.change_user(conn)

    render(conn, "account.html", changeset: changeset)
  end

  # def create(conn, %{"user" => user_params}) do
  #   # We'll leverage `Pow.Plug`, but you can also follow the classic Phoenix way:
  #   # user =
  #   # %MyApp.Users.User{}
  #   #   |> MyApp.Users.User.changeset(user_params)
  #   #   |> MyApp.Repo.insert()

  #   # IO.inspect user_params
  #   conn
  #   |> Pow.Plug.create_user(Map.merge(user_params, %{ "subscriber" => %{ subscriber_email: user_params["email"] }}))
  #   |> case do
  #     {:ok, user, conn} ->
  #       conn
  #         |> put_flash(:info, "You'll need to confirm your e-mail before you can sign in. An e-mail confirmation link has been sent to you. &&")
  #         |> redirect(to: Routes.pow_session_path(conn, :new))

  #     {:error, changeset, conn} ->
  #       render(conn, "new.html", changeset: changeset)
  #   end
  # end
  
end