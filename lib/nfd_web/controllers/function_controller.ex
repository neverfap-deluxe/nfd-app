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

  def change_subscription_dashboard_func(conn, %{"subscribed" => subscribed, "user_id" => user_id, "collection_id" => collection_id, "subscribed_property" => subscribed_property}) do
    subscribed_property_atom = String.to_atom(subscribed_property)

    case Account.get_subscriber_user_id(user_id) do
      nil ->
        redirect_back(conn, 1)

      subscriber ->
        # NOTE: This ensures that they've paid for the course before subscribing.
        collections_access = Account.get_collection_access_by_user_id_and_collection_id(user_id, collection_id)

        if collections_access do 
          if subscribed == "true", do: Account.update_subscriber(subscriber, %{subscribed_property_atom => false})
          if subscribed == "false", do: Account.update_subscriber(subscriber, %{subscribed_property_atom => true})
          redirect_back(conn, 1)
        end
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
