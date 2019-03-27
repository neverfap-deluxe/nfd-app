defmodule NfdWeb.DashboardController do
  use NfdWeb, :controller

  alias Nfd.Content
  alias Nfd.Account
  alias Nfd.EmailLogs

  alias Nfd.Util.Email

  plug :put_layout, "hub.html"

  def dashboard(conn, _params) do
    user = Pow.Plug.current_user(conn)
    create_collection_access_for_free_courses(user)
    subscriber = Pow.Plug.current_user(conn) |> check_subscriber_exists()
    collections_access_list = Account.list_collection_access_by_user_id(user.id)

    collections_audio = Content.list_audio_courses()
    collections_email = Content.list_email_campaigns()

    { _count_property, subscribed_property } = Email.collection_slug_to_subscribed_property("general-newsletter")
    is_subscribed = Map.fetch!(subscriber, subscribed_property)

    # Function to automatically create collection access for free courses i.e.
    

    conn
      |> put_flash(:info, "Welcome back!")
      |> render("dashboard.html", user: user, subscriber: subscriber, collections_audio: collections_audio, collections_email: collections_email, collections_access_list: collections_access_list, is_subscribed: is_subscribed, subscribed_property: subscribed_property)
  end


  
  # Email Campaigns
  def email_campaigns(conn, _params) do
    user = Pow.Plug.current_user(conn)
    create_collection_access_for_free_courses(user)
    subscriber = Pow.Plug.current_user(conn) |> check_subscriber_exists()

    collections = Content.list_email_campaigns()
    render(conn, "email_campaigns.html", subscriber: subscriber, collections: collections)
  end

  def email_campaigns_collection(conn, %{"collection" => collection_slug}) do
    user = Pow.Plug.current_user(conn)
    create_collection_access_for_free_courses(user)

    subscriber = Pow.Plug.current_user(conn) |> check_subscriber_exists()
    collections_access_list = Account.list_collection_access_by_user_id(user.id)

    collections = Content.list_email_campaigns()
    collection = Content.get_collection_slug!(collection_slug)

    { _count_property, subscribed_property } = Email.collection_slug_to_subscribed_property(collection_slug)
    is_subscribed = Map.fetch!(subscriber, subscribed_property)

    has_paid_for_collection =
      collections_access_list
        |> Enum.find(fn(collection) -> 
          collection.collection_id == collection.id and collection.user_id == user.id
        end)
        
    stripe_api_key = get_relevant_stripe_key(conn.host)
    render(conn, "email_campaigns_collection.html", subscriber: subscriber, user: user, collections: collections, collection: collection, collections_access_list: collections_access_list, stripe_api_key: stripe_api_key, is_subscribed: is_subscribed, has_paid_for_collection: has_paid_for_collection, subscribed_property: subscribed_property)
  end

  def email_campaigns_file(conn, %{"collection" => collection, "file" => file}) do
    user = Pow.Plug.current_user(conn)
    create_collection_access_for_free_courses(user)

    subscriber = Pow.Plug.current_user(conn) |> check_subscriber_exists()

    collections = Content.list_email_campaigns()
    collection = Content.get_collection_slug!(collection)
    file = Content.get_file_slug!(file)
    render(conn, "email_campaigns_file.html", subscriber: subscriber, collections: collections, collection: collection, file: file)
  end



  # Audio Courses
  def audio_courses(conn, _params) do
    user = Pow.Plug.current_user(conn)
    create_collection_access_for_free_courses(user)

    subscriber = Pow.Plug.current_user(conn) |> check_subscriber_exists()

    collections = Content.list_audio_courses()
    render(conn, "audio_courses.html", subscriber: subscriber, collections: collections)
  end

  def audio_courses_collection(conn, %{"collection" => collection}) do
    user = Pow.Plug.current_user(conn)
    create_collection_access_for_free_courses(user)

    subscriber = Pow.Plug.current_user(conn) |> check_subscriber_exists()

    collections = Content.list_audio_courses()
    collection = Content.get_collection_slug!(collection)
    render(conn, "audio_courses_collection.html", subscriber: subscriber, collections: collections, collection: collection)
  end

  def audio_courses_file(conn, %{"collection" => collection, "file" => file}) do
    user = Pow.Plug.current_user(conn)
    create_collection_access_for_free_courses(user)

    subscriber = Pow.Plug.current_user(conn) |> check_subscriber_exists()

    collections = Content.list_audio_courses()
    collection = Content.get_collection_slug!(collection)
    file = Content.get_file_slug!(file)
    render(conn, "audio_courses_file.html", subscriber: subscriber, collections: collections, collection: collection, file: file)
  end



  # Profile

  def profile(conn, _params) do
    user = Pow.Plug.current_user(conn)
    create_collection_access_for_free_courses(user)

    subscriber = Pow.Plug.current_user(conn) |> check_subscriber_exists()

    render(conn, "profile.html", subscriber: subscriber)
  end

  def profile_delete_confirmation(conn, _params) do
    user = Pow.Plug.current_user(conn)
    create_collection_access_for_free_courses(user)

    render(conn, "profile_delete_confirmation.html")
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
      {:ok, subscriber} -> subscriber
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
          collection_access -> nil
        end
      end)
  end 
end
