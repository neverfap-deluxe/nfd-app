defmodule NfdWeb.MessageController do
  use NfdWeb, :controller

  alias Nfd.API
  alias Nfd.API.ContentAPI
  alias Nfd.API.PageAPI

  alias Nfd.Meta
  alias Nfd.Account

  alias Nfd.Emails
  alias Nfd.EmailLogs

  alias NfdWeb.Redirects

  alias NfdWeb.FetchConn
  alias NfdWeb.FetchAccess
  alias NfdWeb.FetchCollection

  alias Nfd.Meta.ManualEmails

  # NOTE: This is only suitable for content based comments
  def comment_form_post(conn, %{"comment" => comment}) do
    # TODO: This actually needs to check if the user is logged in, since people can actually still post a comment if they understand how to.

    user = Pow.Plug.current_user(conn) |> Account.get_user_pow!()

    {_referer_key, referer_value} = Enum.find(conn.req_headers, fn({ key, value}) -> key == "referer" end)

    page_symbol = String.split(referer_value, "/") |> Enum.fetch!(3) |> slug_to_symbol()
    content_slug = Redirects.redirect_content(conn, String.split(referer_value, "/") |> Enum.fetch!(4), Atom.to_string(page_symbol))

    comment_with_parent_messge_id = if comment["parent_message_id"] == "", do: Map.delete(comment, "parent_message_id"), else: comment

    case Meta.create_comment(comment_with_parent_messge_id) do
      {:ok, comment} ->
        Emails.cast_comment_made_email(comment.email, comment.message, referer_value) |> Emails.process("cast_comment_made_email #{comment.email} #{comment.message} #{referer_value}" )
        EmailLogs.new_comment_form_email(comment.name, comment.email, comment.message, referer_value, comment.id, conn.host)

        # NOTE: This will only get immediate parent comments, not successive parent comments.
        if comment.parent_message_id do
          parent_comment = Meta.get_comment!(comment.parent_message_id)
          Emails.cast_comment_reply_email(parent_comment.email, comment.name, comment.message, referer_value) |> Emails.process("cast_comment_reply_email #{parent_comment.email} #{comment.name} #{comment.message} #{referer_value}" )
        end

        conn |> redirect(to: Routes.content_path(conn, page_symbol, content_slug))

      {:error, comment_form_changeset} ->
        IO.inspect comment_form_changeset
        client = API.is_localhost(conn.host) |> API.api_client()

        case apply(ContentAPI, page_symbol, [client, content_slug]) do
          {:ok, response} ->
            collection_array = FetchAccess.fetch_access_array(page_symbol)

            user_collections = FetchCollection.user_collections(conn, [:user, :subscriber, :patreon_access, :collections_access_list])
            page_collections = FetchCollection.page_collections(client, collection_array)
            content_collections = FetchCollection.content_collections(client, response.body["data"], page_symbol, content_slug, user_collections, page_collections, collection_array)
            changeset_collections = FetchCollection.changeset_collections(response.body["data"], user_collections[:user], collection_array) |> Map.merge(%{comment_form_changeset: comment_form_changeset})

            conn
              |> FetchConn.check_api_response_for_404(response.status)
              |> put_view(NfdWeb.ContentView)
              |> render("#{Atom.to_string(page_symbol)}.html", layout: { NfdWeb.LayoutView, "general.html" }, item: response.body["data"], user_collections: user_collections, content_collections: content_collections, changeset_collections: changeset_collections, content_collections: content_collections, page_collections: page_collections, page_type: "content")

          {:error, error} ->
            IO.inspect error
            FetchConn.render_404_page(conn, error)
        end
    end
  end

  # NOTE: This is not being used anywhere, and needs to be tested.
  def contact_form_post(conn, %{"contact_form" => contact_form}) do
    {_referer_key, value} = Enum.find(conn.req_headers, fn({ key, value}) -> key == "referer" end)

    first_slug = String.split(value, "/") |> Enum.fetch!(3)
    page_symbol = slug_to_symbol(first_slug)

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

            case apply(PageAPI, page_symbol, [client]) do
              {:ok, response} ->
                collection_array = FetchAccess.fetch_access_array(page_symbol)
                user_collections = FetchCollection.user_collections(conn, [:user, :subscriber, :patreon_access, :collections_access_list])
                page_collections = FetchCollection.page_collections(client, collection_array)
                changeset_collections = FetchCollection.changeset_collections(response.body["data"], user_collections[:user], collection_array) |> Map.merge(%{contact_form_changeset: contact_form_changeset})

                conn
                  |> FetchConn.check_api_response_for_404(response.status)
                  |> put_view(NfdWeb.PageView)
                  |> render("#{Atom.to_string(page_symbol)}.html", layout: { NfdWeb.LayoutView, "general.html" }, item: response.body["data"], user_collections: user_collections, page_collections: page_collections, changeset_collections: changeset_collections, page_type: "page")

                {:error, error} ->
                FetchConn.render_404_page(conn, error)
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
        {:ok, _success} -> EmailLogs.error_email_log("Comment deleted! - #{comment_id}")
        {:error, error} -> EmailLogs.error_email_log("Failed to delete comment - #{error}")
      end
      EmailLogs.error_email_log("Could not delete comment without valid delete_comment_secret token.")
    end
  end


  # MANUAL MESSAGES
  def message_email_hub(conn, _params) do
    render_email_hub(conn)
  end

  def send_manual_message(conn, %{"manual_emails" => manual_emails}) do
    user = Pow.Plug.current_user(conn) |> Account.get_user_pow!()

    # FUTURE: Actually build this.
    if user.is_admin do
      message = manual_emails["message"]
      subject = manual_emails["subject"]
      type = manual_emails["type"] |> List.first()
      
      subscribers = 
        case type do
          "All" -> Account.list_subscribers()
          # "NonSubscribed" -> Account.list_subscribers()
          "General" -> Account.list_subscribers_general()
          "Kickstarter" -> Account.list_subscribers_kickstarter()
          "Meditation" -> Account.list_subscribers_meditation()
          "Awareness" -> Account.list_subscribers_awareness()
          _ -> []
        end
    
      subscribers |> Enum.each(fn (subscriber) -> 
        unsubscribe_email = Email.generate_unsubscribe_url("0h2", subscriber.subscriber_email)

        Emails.cast_general_newsletter_email(subscriber, subject, message, unsubscribe_email) |> Emails.process("Manual Email Sent")
      end)
    end
    
    render_email_hub(conn)
  end

  def render_email_hub(conn) do
    user = Pow.Plug.current_user(conn) |> Account.get_user_pow!()
    if user.is_admin do 
      general_email_changeset = ManualEmails.changeset(%ManualEmails{}, %{message: "", subject: "", type: "All"})
      manual_emails = Meta.list_manual_emails()
      render(conn, "message_email_hub.html", general_email_changeset: general_email_changeset, manual_emails: manual_emails)
    else 
      FetchConn.render_404_page(conn, "error")
    end
  end

  # CONTACT FORM TEMPLATES
  def send_contact_form_success(conn, _params) do
    render(conn, "send_contact_form_success.html")
  end

  def send_message_send_contact_form_failed(conn, %{"message" => message, "error_message" => error_message}) do
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
