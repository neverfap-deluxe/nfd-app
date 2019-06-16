defmodule NfdWeb.MessageController do
  use NfdWeb, :controller

  alias Nfd.API
  alias Nfd.API.Content
  alias Nfd.API.Page

  alias Nfd.Meta
  alias Nfd.Account

  alias Nfd.Emails
  alias Nfd.EmailLogs

  alias NfdWeb.Fetch
  alias NfdWeb.FetchCollection

  def comment_form_post(conn, %{"comment" => comment}) do
    user = Pow.Plug.current_user(conn) |> Account.get_user_pow!()

    {referer_key, referer_value} = Enum.find(conn.req_headers, fn({ key, value}) -> key == "referer" end)

    IO.inspect referer_value

    first_slug = String.split(referer_value, "/") |> Enum.fetch!(3)
    first_slug_symbol = slug_to_symbol(first_slug)
    second_slug = String.split(referer_value, "/") |> Enum.fetch!(4)

    comment_with_parent_messge_id = 
      if comment["parent_message_id"] == "", do: Map.delete(comment, "parent_message_id"), else: comment

    case Meta.create_comment(comment_with_parent_messge_id) do
      {:ok, comment} ->
        # send email to commenter
        Emails.cast_comment_made_email(comment.email, comment.message, referer_value) 
          |> Emails.process("cast_comment_made_email #{comment.email} #{comment.message} #{referer_value}" )
        EmailLogs.new_comment_form_email(comment.name, comment.email, comment.message, referer_value)
         
        # TODO: This will only get immediate parent comments, not successive parent comments.
        if comment.parent_message_id do 
          parent_comment = Meta.get_comment!(comment.parent_message_id)
          Emails.cast_comment_reply_email(parent_comment.email, comment.name, comment.message, referer_value)
            |> Emails.process("cast_comment_reply_email #{parent_comment.email} #{comment.name} #{comment.message} #{referer_value}" )
        end

        conn |> redirect(to: Routes.content_path(conn, first_slug_symbol, second_slug))
        
      {:error, comment_form_changeset} ->
        IO.inspect comment_form_changeset
        client = API.is_localhost(conn.host) |> API.api_client()

        case apply(Content, first_slug_symbol, [client, second_slug]) do
          {:ok, response} ->
            comment_form_changeset = Meta.Comment.changeset(%Meta.Comment{}, %{})

            typical_collections =
              Fetch.fetch_collections(
                response.body["data"],
                user,
                FetchCollection.fetch_collections_array(first_slug_symbol),
                client
              )

            all_collections =
              Map.merge(typical_collections, %{comment_form_changeset: comment_form_changeset})

            Fetch.fetch_response_ok(conn, user, NfdWeb.ContentView, response, all_collections, first_slug_symbol, "general.html", "content")

          {:error, error} ->
            IO.inspect error
            Fetch.render_404_page(conn, error)
        end
    end
  end

  # TODO: Need to test
  def contact_form_post(conn, %{"contact_form" => contact_form}) do
    user = Pow.Plug.current_user(conn) |> Account.get_user_pow!()

    {referer_key, value} = Enum.find(conn.req_headers, fn({ key, value}) -> key == "referer" end)

    first_slug = String.split(value, "/") |> Enum.fetch!(3)
    first_slug_symbol = slug_to_symbol(first_slug)

    case Recaptcha.verify(contact_form["g-recaptcha-response"]) do
      {:ok, _response} ->
        case Account.create_contact_form(contact_form) do
          {:ok, _contact_form} ->
            EmailLogs.new_contact_form_email(
              contact_form["name"],
              contact_form["email"],
              contact_form["message"]
            )

            render(conn, "send_contact_form_success.html")

          {:error, contact_form_changeset} ->
            client = API.is_localhost(conn.host) |> API.api_client()

            case apply(Page, first_slug_symbol, [client]) do
              {:ok, response} ->
                all_collections = %{contact_form_changeset: contact_form_changeset}

                Fetch.fetch_response_ok(
                  conn,
                  user,
                  NfdWeb.PageView,
                  response,
                  all_collections,
                  first_slug_symbol,
                  "general.html",
                  "page"
                )

              {:error, error} ->
                Fetch.render_404_page(conn, error)
            end
        end

      {:error, errors} ->
        EmailLogs.error_email_log(
          "#{contact_form["email"]} - #{contact_form["message"]} - Could not verify captcha - function_controller."
        )

        render(conn, "send_contact_form_failed.html",
          message: contact_form["message"],
          error_message: "Could not verify Captcha"
        )
    end
  end

  def send_contact_form_success(conn, _params) do
    render(conn, "send_contact_form_success.html")
  end

  def send_message_send_contact_form_failed(conn, %{
        "message" => message,
        "error_message" => error_message
      }) do
    render(conn, "send_contact_form_failed.html", message: message, error_message: error_message)
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
end
