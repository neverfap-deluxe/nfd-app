defmodule NfdWeb.FunctionController do
  use NfdWeb, :controller

  alias Nfd.Meta
  alias Nfd.Account

  alias Nfd.Util.Email

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
        collection = Content.get_collection!(collection_id)
        active_type_property = Email.collection_slug_to_active_type_property(collection.slug)
        active_value = Atom.to_string(subscribed_property)

        if (subscribed_property_atom != :subscribed or subscribed_property_atom != :seven_day_kickstarter_subscribed) do
          if subscribed == "true", do: Account.update_subscriber(subscriber, %{active_type_property => active_value, subscribed_property_atom => false})
          if subscribed == "false", do: Account.update_subscriber(subscriber, %{active_type_property => active_value, subscribed_property_atom => true})
          redirect_back(conn, 1)
        end

        # NOTE: This ensures that they've paid for the course before subscribing.
        collections_access = Account.get_collection_access_by_user_id_and_collection_id(user_id, collection_id)

        if collections_access do
          if subscribed == "true", do: Account.update_subscriber(subscriber, %{active_type_property => active_value, subscribed_property_atom => false})
          if subscribed == "false", do: Account.update_subscriber(subscriber, %{active_type_property => active_value, subscribed_property_atom => true})
        end

        # MAYBE: Maybe send an error to the user (perhaps a flash) letting them know it hasn't been successful.
        redirect_back(conn, 1)
    end
  end

  def reset_subscription_dashboard_func(conn, %{"subscribed" => subscribed, "user_id" => user_id, "collection_id" => collection_id, "subscribed_property" => subscribed_property}) do
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
