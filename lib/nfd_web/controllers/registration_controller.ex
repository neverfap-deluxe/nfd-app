defmodule NfdWeb.RegistrationController do
  use NfdWeb, :controller

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

  def new(conn, _params) do
    # We'll leverage `Pow.Plug`, but you can also follow the classic Phoenix way:
    # changeset = MyApp.Users.User.changeset(%MyApp.Users.User{}, %{})

    changeset = Pow.Plug.change_user(conn)

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    # We'll leverage `Pow.Plug`, but you can also follow the classic Phoenix way:
    # user =
    #   %MyApp.Users.User{}
    #   |> MyApp.Users.User.changeset(user_params)
    #   |> MyApp.Repo.insert()

    conn
    |> Pow.Plug.create_user(user_params)
    |> case do
      {:ok, user, conn} ->
        conn
        |> put_flash(:user_email, user.email)
        |> redirect(to: Routes.registration_path(conn, :confirm_email_begin))
        
      {:error, changeset, conn} ->
        render(conn, "account.html", changeset: changeset)
    end
  end
end
