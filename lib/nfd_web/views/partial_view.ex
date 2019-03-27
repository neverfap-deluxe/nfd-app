defmodule NfdWeb.PartialView do
  use NfdWeb, :view

  def subscribed_status(subscribed) do
    if subscribed, do: "Subscribed", else: "Not Subscribed"
  end

  def subscribed_status_text(subscribed) do
    if subscribed, do: "I would like to unsubscribe.", else: "Subscribe me."
  end

  # TODO: Float to integer, times 100
  def float_to_stripe_integer(float) do 
    trunc(float * 100) 
  end
end
