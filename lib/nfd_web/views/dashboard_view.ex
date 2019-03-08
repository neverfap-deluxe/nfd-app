defmodule NfdWeb.DashboardView do
  use NfdWeb, :view

  def subscribed_status(is_subscribed) do
    if is_subscribed do 
      "Subscribed"
    else
      "Not Subscribed"
    end
  end

end
