defmodule Nfd.Paypal do

  # https://developer.paypal.com/docs/checkout/integrate/

  def payment_process(user, collection) do

    # PayPal.Payments.Orders.xxx(order_id)

    case Account.create_collection_access(%{user_id: user.id, collection_id: collection.id}) do
      {:ok, collection_access} -> 
        IO.inspect collection_access
        collection_access
      {:error, error} -> 
        IO.inspect error
        nil
    end
  end

  def create_paypal_session(user, host, collection_slug) do 
    case PayPal.API.get_oauth_token() do 
      {:ok, { token, expires }} -> token
      {:error, error} -> error
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
