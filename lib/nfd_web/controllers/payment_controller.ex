defmodule NfdWeb.PaymentController do
  use NfdWeb, :controller

  alias Nfd.Stripe
  alias Nfd.Paypal

  # https://developer.paypal.com/docs/checkout/integrate/#next

  # https://developer.paypal.com/docs/checkout/reference/server-integration/set-up-transaction

  def paypal_collection_payment(conn, %{"data" => data}) do 
    IO.inspect data
    user = Pow.Plug.current_user(conn) |> Account.get_user_pow!()
    Paypal.payment_process(user, "_collection_id")
  end

  # TODO: Look into stripity_stripe for webhook endpoint creation
  def stripe_collection_payment(conn, %{"data" => data}) do 
    IO.inspect data
    collection_id = data["object"]["client_reference_id"]
    
    # collection_id
    user = Pow.Plug.current_user(conn) |> Account.get_user_pow!()
    Stripe.payment_process(user, collection_id)
  end

  def purchase_success(conn, _params) do
    render(conn, "purchase_success.html")
  end

  def purchase_cancel(conn, _params) do
    render(conn, "purchase_cancel.html")
  end
end
