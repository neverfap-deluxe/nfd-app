defmodule NfdWeb.FunctionController do
  use NfdWeb, :controller

  alias Nfd.Content
  alias Nfd.Account

  def delete_acount(conn, %{"user" => user}) do 
    case Account.delete_user(user) do
      { :ok, empty_user } ->
        # TODO: Send an email to me, signifying that the user deleted themselves.
        redirect(conn, to: Routes.page_path(conn, :home))

      {:error, user } -> 
        IO.inspect(user)
        redirect(conn, to: Routes.page_path(conn, :home))
    end
  end

end
