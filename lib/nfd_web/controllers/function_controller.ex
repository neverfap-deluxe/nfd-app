defmodule NfdWeb.FunctionController do
  use NfdWeb, :controller

  alias Nfd.Meta
  alias Nfd.Account

  alias Nfd.Patreon

  alias NfdWeb.FetchCollection
  alias NfdWeb.FetchDashboard

<<<<<<< HEAD
  # PATREON

  def validate_patreon(conn, %{"code" => code}) do
    Patreon.validate_patreon_code(conn, code)
    
    FetchDashboard.fetch_dashboard(conn, :dashboard, "", "", FetchCollection.fetch_collections_array(:dashboard))
=======
  def comment_form_post(conn, %{"comment" => comment}) do
    {referer, value} = Enum.fetch!(conn.req_headers, 10)

    first_slug = String.split(value, "/") |> Enum.fetch!(3)
    first_slug_symbol = slug_to_symbol(first_slug)
    second_slug = String.split(value, "/") |> Enum.fetch!(4)

    client = API.is_localhost(conn.host) |> API.api_client()

    case Meta.create_comment(comment) do
      {:ok, generated_comment} ->
        IO.inspect generated_comment

        case apply(Content, first_slug_symbol, [client, second_slug]) do
          {:ok, response} ->
            EmailLogs.new_comment_form_email(generated_comment.name, generated_comment.email, generated_comment.message)
            all_collections = Fetch.fetch_collections(response.body["data"], FetchCollection.fetch_collections_array(first_slug_symbol), client)

            Fetch.fetch_response_ok(conn, NfdWeb.ContentView, response, all_collections, first_slug_symbol, "general.html", "content")
          {:error, error} ->
            Fetch.render_404_page(conn, error)
        end
        # redirect_back(conn)
      {:error, comment_form_changeset} ->
        IO.inspect comment_form_changeset

        case apply(Content, first_slug_symbol, [client, second_slug]) do
          {:ok, response} ->
            typical_collections = Fetch.fetch_collections(response.body["data"], FetchCollection.fetch_collections_array(first_slug_symbol), client)
            all_collections = Map.merge(typical_collections, %{ comment_form_changeset: comment_form_changeset })
            Fetch.fetch_response_ok(conn, NfdWeb.ContentView, response, all_collections, first_slug_symbol, "general.html", "content")
          {:error, error} ->
            Fetch.render_404_page(conn, error)
        end
    end
>>>>>>> production
  end

  # SUBSCRIPTION

  def change_subscription_dashboard_func(conn, %{
        "subscribed" => subscribed,
        "user_id" => user_id,
        "subscribed_property" => subscribed_property
      }) do
    subscribed_property_atom = String.to_atom(subscribed_property)

    case Account.get_subscriber_user_id(user_id) do
      nil ->
        redirect_back(conn, 1)

      subscriber ->
        if subscribed == "true",
          do: Account.update_subscriber(subscriber, %{subscribed_property_atom => false})

        if subscribed == "false",
          do: Account.update_subscriber(subscriber, %{subscribed_property_atom => true})

        redirect_back(conn, 1)
    end
  end

  def reset_subscription_dashboard_func(conn, %{
        "subscribed" => subscribed,
        "user_id" => user_id,
        "count_property" => count_property
      }) do
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
