defmodule NfdWeb.DashboardView do
  use NfdWeb, :view

  defp check_is_subscribed(subscribed_property) do
    if (subscribed_property == true) do
      "Subscribed"
    else
      "Unsubscribed"
    end
  end

end
