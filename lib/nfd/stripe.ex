defmodule Nfd.Stripe do

  alias Nfd.Account
  alias Nfd.Content

  alias Nfd.Util.Email

  alias Nfd.Emails
  alias Nfd.EmailLogs

  # https://stripe.com/docs/payments/checkout/client#enable
  # https://stripe.com/docs/webhooks/setup

  def payment_process(conn, user, collection) do
    case Account.create_collection_access(%{user_id: user.id, collection_id: collection.id, amount_paid: collection.price }) do
      {:ok, _collection_access} ->
        # MAYBE - if sending this, it will also have to subscribe user as well to the course, otherwise it's pointless.
        # matrix = Email.collection_slug_to_matrix(collection.slug)
        # Emails.send_day_0_email(subscriber, matrix)
        EmailLogs.success_payment_email_log("#{user.email} - $#{collection.price} - #{collection.display_name}")

        conn |> Plug.Conn.send_resp(200, "Payment Successful")

      {:error, _error} ->
        EmailLogs.failure_payment_email_log("#{user.email} - $#{collection.price} - #{collection.display_name}")
        conn |> Plug.Conn.send_resp(200, "Payment Unsuccessful")
      end
  end

  def create_stripe_session(user, host, collection_slug) do
    collection = Content.get_collection_slug_with_files!(collection_slug)
    query = URI.encode_query(%{ "display_name" => collection.display_name })
    IO.inspect query

    if collection.premium == false do
      %{} # id: ""
    else
      params = %{
        cancel_url: "#{get_base_url(host)}purchase_cancel?#{query}",
        payment_method_types: ["card"],
        success_url: "#{get_base_url(host)}purchase_success?#{query}",
        customer_email: user.email,
        # Maybe this should be the seed_id instead, since payment_intent_data doesn't work, I don't think.
        client_reference_id: "#{user.id}|#{collection.id}",
        payment_intent_data: %{
          description: collection.seed_id
        },
        line_items: [
          %{
            name: collection.display_name,
            description: collection.description,
            images: ["https://neverfapdeluxe.com/images/logo__out__400.png"],
            amount: float_to_stripe_integer(collection.price),
            currency: "aud",
            quantity: 1
          }
        ]
      }

      #   -d line_items[][name]=T-shirt \
      #   -d line_items[][description]="Comfortable cotton t-shirt" \
      #   -d line_items[][images][]="https://example.com/t-shirt.png" \
      #   -d line_items[][amount]=500 \
      #   -d line_items[][currency]=aud \
      #   -d line_items[][quantity]=1 \

      # optional(:client_reference_id) => String.t(),
      # optional(:customer_email) => String.t(),
      # optional(:line_items) => [line_item()],
      # optional(:locale) => String.t(),
      # optional(:payment_intent_data) => payment_intent_data(),
      # optional(:subscription_data) => subscription_data()

      case Stripe.Session.create(params) do
        {:ok, stripe_session} -> stripe_session
        {:error, error} ->
          IO.inspect(error)
          %{}
      end
    end
  end

  def get_base_url(host) do
    if host == "localhost" do
      "http://localhost:4000/"
    else
      "https://neverfapdeluxe.com/"
    end
  end

  def get_api_key(host) do
    if host == "localhost" do
      System.get_env("STRIPE_API_TEST_KEY")
    else
      System.get_env("STRIPE_API_KEY")
    end
  end

  defp float_to_stripe_integer(float) do
    trunc(float * 100)
  end
end
