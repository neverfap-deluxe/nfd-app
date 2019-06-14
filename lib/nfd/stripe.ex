defmodule Nfd.Stripe do
  # Helper Functions
  def get_relevant_stripe_key(host) do
    if host == "localhost" do
      "pk_test_ShlsB93VF6UPAeaGzhC3Lmue"
    else
      System.get_env("STRIPE_API_KEY")
    end
  end

  def update_collection_information do 

  end
end
