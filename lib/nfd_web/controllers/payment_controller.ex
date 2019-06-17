defmodule NfdWeb.PaymentController do
  use NfdWeb, :controller

  alias Nfd.Stripe
  alias Nfd.PayPal

  # <script src="https://www.paypal.com/sdk/js?client-id=sb"></script>
  # <script>paypal.Buttons().render('body');</script>

  def paypal_collection_payment(conn, %{"random" => random}) do 
    user = Pow.Plug.current_user(conn) |> Account.get_user_pow!()
    PayPal.payment_process()
  end

  def stripe_collection_payment(conn, %{"random" => random}) do 
    user = Pow.Plug.current_user(conn) |> Account.get_user_pow!()
    Stripe.payment_process()
  end
end
