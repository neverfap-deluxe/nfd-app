defmodule NfdWeb.FunctionController do
  use NfdWeb, :controller

  alias Nfd.Account

  alias Nfd.EmailLogs

  alias NfdWeb.API
  alias NfdWeb.API.Page
  alias Nfd.Meta

  def contact_form_post(conn, %{"contact_form" => contact_form}) do
    name = contact_form["name"]
    email = contact_form["email"]
    message = contact_form["message"]

    # TODO: Need to test
    case Recaptcha.verify(contact_form["g-recaptcha-response"]) do
      {:ok, _response} -> 
        case Account.create_contact_form(contact_form) do
          {:ok, contact_form} ->
            EmailLogs.new_contact_form_email(name, email, message)
            render(conn, "send_message_success.html") 
    
          {:error, contact_form_changeset} ->
            page_type = "page"
            client = API.is_localhost(conn.host) |> API.api_client()
            case client |> Page.about() do
              {:ok, response} ->
                Meta.increment_visit_count(response.body["data"])
                conn |> render("about.html", item: response.body["data"], contact_form_changeset: contact_form_changeset, page_type: page_type)
              {:error, _error} ->
                conn |> render(NfdWeb.ErrorView, "404.html")
            end
        end
        
      {:error, errors} -> 
        render(conn, "send_message_failed.html", message: message) 

    end
  end

  def send_message_success(conn, _params) do
    render(conn, "send_message_success.html")
  end

  def send_message_send_message_failed(conn, %{ "message" => message}) do
    render(conn, "send_message_failed.html", message: message)
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
