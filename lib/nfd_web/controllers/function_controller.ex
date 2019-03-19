defmodule NfdWeb.FunctionController do
  use NfdWeb, :controller

  alias Nfd.Account

  alias Nfd.EmailLogs

  def contact_form_post(conn, %{"contact_form" => contact_form}) do
    name = contact_form["name"]
    email = contact_form["email"]
    message = contact_form["message"]

    # Account.create_contact_form({})
    case Recaptcha.verify(contact_form["g-recaptcha-response"]) do
      {:ok, _response} -> 
        EmailLogs.new_contact_form_email(name, email, message)
        redirect(conn, to: Routes.function_path(conn, :send_message_success))
    
      {:error, errors} -> 
        IO.inspect errors
        redirect(conn, to: Routes.page_path(conn, :home))
    end
  end

  def send_message_success(conn, _params) do
    render(conn, "send_message_success.html")
  end

  def delete_acount(conn, %{"user" => user}) do 
    case Account.delete_user(user) do
      {:ok, _empty_user} ->
        Nfd.EmailLogs.user_deleted_email(user.email)
        redirect(conn, to: Routes.page_path(conn, :home))

      {:error, _error} -> 
        redirect(conn, to: Routes.page_path(conn, :home))
    end
  end

end
