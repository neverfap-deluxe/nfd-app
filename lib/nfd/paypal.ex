defmodule Nfd.Paypal do

  alias Nfd.Account
  alias Nfd.Content

  alias Nfd.Util.Email

  alias Nfd.Emails
  alias Nfd.EmailLogs

  # https://developer.paypal.com/docs/checkout/integrate/

  def payment_process(conn, user, subscriber, collection) do
    case Account.create_collection_access(%{user_id: user.id, collection_id: collection.id, amount_paid: collection.price}) do
      {:ok, collection_access} ->
        # MAYBE - if sending this, it will also have to subscribe user as well to the course, otherwise it's pointless.
        # matrix = Email.collection_slug_to_matrix(collection.slug)
        # Emails.send_day_0_email(subscriber, matrix)
        EmailLogs.success_payment_email_log("#{user.email} - $#{collection.price} - #{collection.display_name}")
        conn |> Plug.Conn.send_resp(200, "Payment Successful")
      {:error, error} ->
        EmailLogs.failure_payment_email_log("#{user.email} - $#{collection.price} - #{collection.display_name}")
        conn |> Plug.Conn.send_resp(403, "Payment Unsuccessful")
      end
  end

  def create_paypal_session(user, host, collection_slug) do
    case PayPal.API.get_oauth_token() do
      {:ok, { token, expires }} -> token
      {:error, error} ->
        IO.inspect error
        nil
    end
  end

  def get_api_key(host) do
    if host == "localhost" do
      System.get_env("PAYPAL_API_TEST_KEY")
    else
      System.get_env("PAYPAL_API_KEY")
    end
  end

end
