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
  alias NfdWeb.FetchAccess

  # NOTE: This should be suitable for any content based comments
  def comment_form_post(conn, %{"comment" => comment}) do
    user = Pow.Plug.current_user(conn) |> Account.get_user_pow!()

    {referer_key, referer_value} = Enum.find(conn.req_headers, fn({ key, value}) -> key == "referer" end)

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
        EmailLogs.new_comment_form_email(comment.name, comment.email, comment.message, referer_value, comment.id, conn.host)

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
            collection_array = FetchCollection.fetch_access_array(first_slug_symbol)
            user_collections = FetchCollection.user_collections(conn, [:user, :subscriber, :patreon_access, :collections_access_list])
            content_collections = FetchCollection.content_collections(response.body["data"], collection_array, client)
            changeset_collections = FetchCollection.changeset_collections(response.body["data"], user, collection_array) |> Map.merge(%{comment_form_changeset: comment_form_changeset})

            Fetch.fetch_response_ok(conn, user, NfdWeb.ContentView, response, user_collections, content_collections, changeset_collections, first_slug_symbol, "general.html", "content")
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
                collection_array = FetchCollection.fetch_access_array(first_slug_symbol)
                user_collections = FetchCollection.user_collections(conn, [:user, :subscriber, :patreon_access, :collections_access_list])
                content_collections = FetchCollection.content_collections(response.body["data"], collection_array, client)
                changeset_collections = FetchCollection.changeset_collections(response.body["data"], user, collection_array) |> Map.merge(%{comment_form_changeset: comment_form_changeset})

                Fetch.fetch_response_ok(conn, user, NfdWeb.ContentView, response, user_collections, content_collections, changeset_collections, first_slug_symbol, "general.html", "page")
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

  def upvote_comment(conn, %{"comment_id" => comment_id}) do
    comment = Meta.get_comment!(comment_id)
    # NOTE: It MUST be it's own collection, otherwise it won't work essentially :D
    # Perhaps this should be it's own collection in the database, because it needs to have a user/email associated with it.
    # case Meta.upvote_comment(comment_id, %{ upvote_tally: comment.upvote_tally + 1 }) do

    # end
  end

  def comment_delete(conn, %{"comment_id" => comment_id, "delete_comment_secret" => delete_comment_secret}) do
    if System.get_env("DELETE_COMMENT_SECRET") == delete_comment_secret do
      comment = Meta.get_comment!(comment_id)
      case Meta.delete_comment(comment) do
        {:ok, success} -> EmailLogs.serror_email_log("Comment deleted! - #{comment_id}")
        {:error, error} -> EmailLog.serror_email_log("Failed to delete comment - #{error}")
      end
      EmailLogs.error_email_log("Could not delete comment without valid delete_comment_secret token.")
    end
  end


  # CONTACT FORM TEMPLATES
  def send_contact_form_success(conn, _params) do
    render(conn, "send_contact_form_success.html")
  end

  def send_message_send_contact_form_failed(conn, %{
        "message" => message,
        "error_message" => error_message
      }) do
    render(conn, "send_contact_form_failed.html", message: message, error_message: error_message)
  end

  # MESSAGE HELPERS
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
