defmodule NfdWeb.PartialView do
  use NfdWeb, :view

  def subscribed_status(subscribed) do
    if subscribed, do: "Subscribed", else: "Not Subscribed"
  end

  def subscribed_status_text(subscribed) do
    if subscribed, do: "I Would Like To Unsubscribe", else: "Subscribe Me"
  end

  def available_item_subscribed_status_text(subscribed) do
    if subscribed, do: "Unsubscribe", else: "Subscribe"
  end
end
