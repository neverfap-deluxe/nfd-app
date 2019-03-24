defmodule NfdWeb.DashboardController do
  use NfdWeb, :controller

  alias Nfd.Content
  alias Nfd.Account
  alias Nfd.EmailLogs

  plug :put_layout, "hub.html"

  def dashboard(conn, _params) do
    user = Pow.Plug.current_user(conn)
    subscriber = Pow.Plug.current_user(conn) |> check_subscriber_exists()

    collections_audio = Content.list_audio_courses()
    collections_email = Content.list_email_campaigns()
    conn
      |> put_flash(:info, "Welcome back!")
      |> render("dashboard.html", user: user, subscriber: subscriber, collections_audio: collections_audio, collections_email: collections_email)
  end

  # audio courses
  def audio_courses(conn, _params) do
    subscriber = Pow.Plug.current_user(conn) |> check_subscriber_exists()

    collections = Content.list_audio_courses()
    render(conn, "audio_courses.html", subscriber: subscriber, collections: collections)
  end

  def audio_courses_collection(conn, %{"collection" => collection}) do
    subscriber = Pow.Plug.current_user(conn) |> check_subscriber_exists()

    collections = Content.list_audio_courses()
    collection = Content.get_collection_slug!(collection)
    render(conn, "audio_courses_collection.html", subscriber: subscriber, collections: collections, collection: collection)
  end

  def audio_courses_file(conn, %{"collection" => collection, "file" => file}) do
    subscriber = Pow.Plug.current_user(conn) |> check_subscriber_exists()

    collections = Content.list_audio_courses()
    collection = Content.get_collection_slug!(collection)
    file = Content.get_file_slug!(file)
    render(conn, "audio_courses_file.html", subscriber: subscriber, collections: collections, collection: collection, file: file)
  end

  # email challenges
  def email_campaigns(conn, _params) do
    subscriber = Pow.Plug.current_user(conn) |> check_subscriber_exists()

    collections = Content.list_email_campaigns()
    render(conn, "email_campaigns.html", subscriber: subscriber, collections: collections)
  end

  def email_campaigns_collection(conn, %{"collection" => collection}) do
    subscriber = Pow.Plug.current_user(conn) |> check_subscriber_exists()

    collections = Content.list_email_campaigns()
    collection = Content.get_collection_slug!(collection)
    render(conn, "email_campaigns_collection.html", subscriber: subscriber, collections: collections, collection: collection)
  end

  def email_campaigns_file(conn, %{"collection" => collection, "file" => file}) do
    subscriber = Pow.Plug.current_user(conn) |> check_subscriber_exists()

    collections = Content.list_email_campaigns()
    collection = Content.get_collection_slug!(collection)
    file = Content.get_file_slug!(file)
    render(conn, "email_campaigns_file.html", subscriber: subscriber, collections: collections, collection: collection, file: file)
  end

  def profile(conn, _params) do
    subscriber = Pow.Plug.current_user(conn) |> check_subscriber_exists()

    render(conn, "profile.html", subscriber: subscriber)
  end

  def profile_delete_confirmation(conn, _params) do
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
      {:error, error} -> EmailLogs.error_email_log("#{user_email} - #{user_id} - Could not create subscriber - :check_subscriber_exists_create_subscriber.")
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

end
