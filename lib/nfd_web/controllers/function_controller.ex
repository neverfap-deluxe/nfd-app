defmodule NfdWeb.FunctionController do
  use NfdWeb, :controller

  alias Nfd.Account

  alias Nfd.EmailLogs

  alias Nfd.API
  alias Nfd.API.Content
  alias Nfd.API.Page
  alias Nfd.Meta

  alias NfdWeb.Fetch

  def comment_form_post(conn, %{"comment_form" => comment_form}) do
    first_slug = conn.path_info |> List.at(0)
    first_slug_symbol = String.to_atom(first_slug)
    second_slug = conn.path_info |> List.at(1)

    case Meta.create_comment(comment_form) do
      {:ok, _comment_form} ->
        EmailLogs.new_comment_form_email(comment_form["name"], comment_form["email"], comment_form["message"])
        redirect_back(conn)
      {:error, comment_form_changeset} ->
        client = API.is_localhost(conn.host) |> API.api_client()

        case apply(Content, first_slug_symbol, [client, second_slug]) do
          {:ok, response} ->
            comment_form_changeset = Meta.Comment.changeset(%Meta.Comment{}, %{})
            typical_collections = Fetch.fetch_collections(FetchCollection.fetch_collections_array(first_slug_symbol))
            all_collections = Map.merge(typical_collections, %{ comment_form_changeset: comment_form_changeset })
            Fetch.fetch_response_ok(conn, response, all_collections, first_slug_symbol, "general.html", "content")
          {:error, error} ->
            Fetch.render_404_page(conn, error)
        end
    end
  end

  # TODO: Need to test
  def contact_form_post(conn, %{"contact_form" => contact_form}) do
    first_slug = conn.path_info |> List.at(0)
    first_slug_symbol = String.to_atom(first_slug)

    case Recaptcha.verify(contact_form["g-recaptcha-response"]) do
      {:ok, _response} ->
        case Account.create_contact_form(contact_form) do
          {:ok, _contact_form} ->
            EmailLogs.new_contact_form_email(contact_form["name"], contact_form["email"], contact_form["message"])
            render(conn, "send_message_success.html")

          {:error, contact_form_changeset} ->
            client = API.is_localhost(conn.host) |> API.api_client()
            all_collections = %{ contact_form_changeset: contact_form_changeset }
            Fetch.fetch_response_ok(conn, response, all_collections, :first_slug_symbol, "general.html", "page")
        end

      {:error, errors} ->
        EmailLogs.error_email_log("#{email} - #{message} - Could not verify captcha - function_controller.")
        render(conn, "send_message_failed.html", message: message, error_message: "Could not verify Captcha")
    end
  end

  defp slug_to_symbol(slug) do
    case slug do
      "articles" -> :article
      "practices" -> :practice
      "courses" -> :course
      "podcast" -> :podcast
      "quotes" -> :quote
      "meditation" -> :meditation
      "blogs" -> :blog
      "updates" -> :update
    end
  end

  def send_message_success(conn, _params) do
    render(conn, "send_message_success.html")
  end

  def send_message_send_message_failed(conn, %{ "message" => message, "error_message" => error_message}) do
    render(conn, "send_message_failed.html", message: message, error_message: error_message)
  end
end
