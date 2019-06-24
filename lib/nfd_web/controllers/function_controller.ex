defmodule NfdWeb.FunctionController do
  use NfdWeb, :controller

  alias Nfd.Meta
  alias Nfd.Account

  alias Nfd.Patreon

  alias NfdWeb.FetchAccess
  alias NfdWeb.FetchDashboard

  # PATREON

  def validate_patreon(conn, %{"code" => code}) do
    user = Pow.Plug.current_user(conn) |> Account.get_user_pow!()
    Patreon.validate_patreon_code(conn, user, code)

    redirect(conn, to: Routes.dashboard_path(conn, :dashboard))
  end

  # SUBSCRIPTION

  def change_subscription_dashboard_func(conn, %{"subscribed" => subscribed, "user_id" => user_id, "subscribed_property" => subscribed_property}) do
    subscribed_property_atom = String.to_atom(subscribed_property)

    case Account.get_subscriber_user_id(user_id) do
      nil ->
        redirect_back(conn, 1)

      subscriber ->
        # TODO: Here is where it needs to check to see if they're already subscribed to other emails. Oh wait, this is that function.
        # NOTE: Perhaps the UI simply shouldn't allow them to update their subscriptions, because at this point it's a bit pointless.
        if subscribed == "true",
          do: Account.update_subscriber(subscriber, %{subscribed_property_atom => false})

        if subscribed == "false",
          do: Account.update_subscriber(subscriber, %{subscribed_property_atom => true})

        redirect_back(conn, 1)
    end
  end

  def reset_subscription_dashboard_func(conn, %{"subscribed" => subscribed,"user_id" => user_id,"count_property" => count_property}) do
    count_property_atom = String.to_atom(count_property)

    case Account.get_subscriber_user_id(user_id) do
      nil ->
        redirect(conn, to: Routes.dashboard_path(conn, :dashboard))

      subscriber ->
        Account.update_subscriber(subscriber, %{count_property_atom => 0})
        redirect_back(conn, 1)
    end
  end
end
