defmodule NfdWeb.FetchDashboard do
  use NfdWeb, :controller

  alias Nfd.Content
  alias Nfd.Account
  alias Nfd.EmailLogs

  alias Nfd.Util.Email

  def fetch_dashboard(conn, page_symbol, collection_slug, file_slug, collection_array) do
    user = Pow.Plug.current_user(conn)
    create_collection_access_for_free_courses(user)
    subscriber = Pow.Plug.current_user(conn) |> check_subscriber_exists()
    collections_access_list = Account.list_collection_access_by_user_id(user.id)

    create_collection_access_for_free_courses(user)

    { _count_property, subscribed_property } = Email.collection_slug_to_subscribed_property("general-newsletter")
    is_subscribed = Map.fetch!(subscriber, subscribed_property)

    collections = fetch_dashboard_collections(conn, collection_array, collections_access_list, collection_slug, file_slug, user)
    conn
      |> put_flash(:info, "Welcome back!")
      |> render(
        "#{Atom.to_string(page_symbol)}.html",
        layout: { NfdWeb.LayoutView, "hub.html" },
        user: user,
        subscriber: subscriber,
        collections_access_list: collections_access_list,
        is_subscribed: is_subscribed,
        subscribed_property: subscribed_property,
        collections: collections
      )
  end

  defp fetch_dashboard_collections(conn, collection_array, collections_access_list, collection_slug, file_slug, user) do
    Enum.reduce(
      collection_array,
      %{},
      fn x, acc ->
        case x do
          # COLLECTIONS
          :collection_audio ->
            collection_audio = Content.get_collection_slug!(collection_slug)
            has_paid_for_collection = has_paid_for_collection(collections_access_list, collection_audio, user)
            Map.merge(acc, %{
              collection_audio: collection_audio,
              has_paid_for_collection: has_paid_for_collection
            })

          :collection_email ->
            collection_email = Content.get_collection_slug!(collection_slug)
            has_paid_for_collection = has_paid_for_collection(collections_access_list, collection_email, user)
            Map.merge(acc, %{
              collection_email: collection_email,
              has_paid_for_collection: has_paid_for_collection
            })

          :collections_audio ->
            collections_audio = Content.list_audio_courses()
            Map.put(acc, :collections_audio, collections_audio)

          :collections_email ->
            collections_email = Content.list_email_campaigns()
            Map.put(acc, :collections_email, collections_email)

          :collections_audio_file ->
            collections_audio_file = Content.get_file_slug!(file_slug)
            Map.put(acc, :collections_audio_file, collections_audio_file)

          :collections_email_file ->
            collections_email_file = Content.get_file_slug!(file_slug)
            Map.put(acc, :collections_email_file, collections_email_file)

            # No idea bout this, I'm sure it's relevant/useful.
            # collections_email_raw
            #   |> Enum.filter(fn(collection) ->
            #     collection_added_to_access_list = Enum.find(collections_access_list, fn(access_list) -> access_list.collection_id == collection.id end)
            #     if collection_added_to_access_list, do: false, else: true
            #   end)
            # collections_email_purchased = collections_email_raw |> Enum.filter()
            #   collections_email_available =
            #     collections_email_raw
            #       |> Enum.filter(fn(collection) ->
            #         collection_added_to_access_list = Enum.find(collections_access_list, fn(access_list) -> access_list.collection_id == collection.id end)
            #         if collection_added_to_access_list, do: true, else: false
            #       end)

            :stripe_api_key ->
              stripe_api_key = get_relevant_stripe_key(conn.host)
              Map.put(acc, :stripe_api_key, stripe_api_key)

          _ ->
            acc
        end
      end)
    end


  defp has_paid_for_collection(collections_access_list, collection, user) do
    collections_access_list
      |> Enum.find(fn(list_collection) ->
        list_collection.collection_id == collection.id and list_collection.user_id == user.id
      end)
  end

  # Check if subscriber exists
  defp check_subscriber_exists(user) do
    # Check is subscriber email already exists.
    case Account.get_subscriber_email(user.email) do
      nil -> check_subscriber_exists_create_subscriber(user.email, user.id)
      subscriber -> check_subscriber_exists_update_subscriber(subscriber, user)
    end
  end

  defp check_subscriber_exists_create_subscriber(user_email, user_id) do
    case Account.create_subscriber(%{ subscriber_email: user_email, user_id: user_id }) do
      {:ok, subscriber} ->
        # NOTE: I think there's an issue where this only sometimes returns the subscriber_email.
        subscriber
      {:error, _error} -> EmailLogs.error_email_log("#{user_email} - #{user_id} - Could not create subscriber - :check_subscriber_exists_create_subscriber.")
    end
  end

  defp check_subscriber_exists_update_subscriber(subscriber, user) do
    if subscriber.user_id != user.id do
      case Account.update_subscriber(subscriber, %{user_id: user.id}) do
        {:ok, subscriber_with_user_id} -> subscriber_with_user_id
        {:error, _changeset} -> EmailLogs.error_email_log("#{subscriber.subscriber_email} - Could not update subscriber - :check_subscriber_exists_update_subscriber.")
      end
    else
      subscriber
    end
  end

  # Helper Functions
  defp get_relevant_stripe_key(host) do
    if host == "localhost" do
      "pk_test_ShlsB93VF6UPAeaGzhC3Lmue"
    else
      System.get_env("STRIPE_API_KEY")
    end
  end

  # Change subscription general
  def change_subscription_dashboard_func(conn, %{"subscribed" => subscribed, "user_id" => user_id, "subscribed_property" => subscribed_property}) do
    subscribed_property_atom = String.to_atom(subscribed_property)

    case Account.get_subscriber_user_id(user_id) do
      nil -> redirect_back(conn, 1)
      subscriber ->
        if subscribed == "true", do: Account.update_subscriber(subscriber, %{ subscribed_property_atom => false })
        if subscribed == "false", do: Account.update_subscriber(subscriber, %{ subscribed_property_atom => true })
        redirect_back(conn, 1)
    end
  end

  def reset_subscription_dashboard_func(conn, %{"subscribed" => subscribed, "user_id" => user_id, "count_property" => count_property}) do
    count_property_atom = String.to_atom(count_property)

    case Account.get_subscriber_user_id(user_id) do
      nil -> redirect(conn, to: Routes.dashboard_path(conn, :dashboard))
      subscriber ->
        Account.update_subscriber(subscriber, %{ count_property_atom => 0 })
        redirect_back(conn, 1)
    end
  end

  def create_collection_access_for_free_courses(user) do
    ["seven-day-neverfap-deluxe-kickstarter"]
      |> Enum.each(fn(slug) ->
        collection = Content.get_collection_slug!(slug)
        case Account.get_collection_access_by_user_id_and_collection_id(user.id, collection.id) do
          nil ->
            case Account.create_collection_access(%{ user_id: user.id, collection_id: collection.id }) do
              {:ok, collection_access } -> collection_access
              {:error, _error} -> nil
            end
          _collection_access -> nil
        end
      end)
  end
end
