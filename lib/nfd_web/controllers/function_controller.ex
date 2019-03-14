defmodule NfdWeb.FunctionController do
  use NfdWeb, :controller

  alias Nfd.Content
  alias Nfd.Account

  alias Nfd.EmailLogs

  def contact_form_post(conn, %{"contact_form" => contact_form}) do
    name = contact_form["name"]
    email = contact_form["email"]
    message = contact_form["message"]

    EmailLogs.new_contact_form_email(name, email, message)
    redirect(conn, to: Routes.function_path(conn, :send_message_success))
  end

  def send_message_success(conn, _params) do
    render(conn, "send_message_success.html")
  end

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
