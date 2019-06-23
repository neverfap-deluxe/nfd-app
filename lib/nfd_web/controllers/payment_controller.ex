defmodule NfdWeb.PaymentController do
  use NfdWeb, :controller

  alias Nfd.Account
  alias Nfd.Content

  alias Nfd.Stripe
  alias Nfd.Paypal

  # https://developer.paypal.com/docs/checkout/integrate/#next

  # https://developer.paypal.com/docs/checkout/reference/server-integration/set-up-transaction

  def paypal_collection_payment(conn, _params) do 
    # user = Account.get_user!()
    Paypal.payment_process("user", "relevant")
  end

  def stripe_collection_payment(conn, %{"data" => data}) do 
    relevant = data["object"]
    relevant = data["object"]

    user_id = relevant["client_reference_id"] |> String.split("|") |> List.first()
    collection_id = relevant["client_reference_id"] |> String.split("|") |> List.last()

    user = Account.get_user!(user_id)
    collection = Content.get_collection!(collection_id)

    Stripe.payment_process(conn, user, collection)
  end

  def purchase_success(conn, _params) do
    display_name = conn.params["display_name"]
    conn |> render("purchase_success.html", layout: {NfdWeb.LayoutView, "hub.html"}, display_name: display_name)
  end

  def purchase_cancel(conn, _params) do
    display_name = conn.params["display_name"]
    conn |> render("purchase_cancel.html", layout: {NfdWeb.LayoutView, "hub.html"}, display_name: display_name)
  end
end
