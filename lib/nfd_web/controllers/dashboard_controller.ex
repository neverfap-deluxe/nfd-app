defmodule NfdWeb.DashboardController do
  use NfdWeb, :controller

  alias Nfd.Content
  alias Nfd.Account

  plug :put_layout, "hub.html"

  def dashboard(conn, _params) do
    user = Pow.Plug.current_user(conn)
    subscriber = Pow.Plug.current_user(conn) |> check_if_subscriber_exists()

    collections_audio = Content.list_audio_courses()
    collections_email = Content.list_email_campaigns()

    conn
      |> put_flash(:info, "Welcome back!")
      |> render("dashboard.html", user: user, subscriber: subscriber, collections_audio: collections_audio, collections_email: collections_email)
  end

  # audio courses
  def audio_courses(conn, _params) do
    subscriber = Pow.Plug.current_user(conn) |> check_if_subscriber_exists()

    collections = Content.list_audio_courses()
    render(conn, "audio_courses.html", subscriber: subscriber, collections: collections)
  end

  def audio_courses_collection(conn, %{"collection" => collection}) do
    subscriber = Pow.Plug.current_user(conn) |> check_if_subscriber_exists()

    collections = Content.list_audio_courses()
    collection = Content.get_collection_slug!(collection)
    render(conn, "audio_courses_collection.html", subscriber: subscriber, collections: collections, collection: collection)
  end

  def audio_courses_file(conn, %{"collection" => collection, "file" => file}) do
    subscriber = Pow.Plug.current_user(conn) |> check_if_subscriber_exists()

    collections = Content.list_audio_courses()
    collection = Content.get_collection_slug!(collection)
    file = Content.get_file_slug!(file)
    render(conn, "audio_courses_file.html", subscriber: subscriber, collections: collections, collection: collection, file: file)
  end

  # email challenges
  def email_campaigns(conn, _params) do
    subscriber = Pow.Plug.current_user(conn) |> check_if_subscriber_exists()

    collections = Content.list_email_campaigns()
    render(conn, "email_campaigns.html", subscriber: subscriber, collections: collections)
  end

  def email_campaigns_collection(conn, %{"collection" => collection}) do
    subscriber = Pow.Plug.current_user(conn) |> check_if_subscriber_exists()

    collections = Content.list_email_campaigns()
    collection = Content.get_collection_slug!(collection)
    render(conn, "email_campaigns_collection.html", subscriber: subscriber, collections: collections, collection: collection)
  end

  def email_campaigns_file(conn, %{"collection" => collection, "file" => file}) do
    subscriber = Pow.Plug.current_user(conn) |> check_if_subscriber_exists()

    collections = Content.list_email_campaigns()
    collection = Content.get_collection_slug!(collection)
    file = Content.get_file_slug!(file)
    render(conn, "email_campaigns_file.html", subscriber: subscriber, collections: collections, collection: collection, file: file)
  end

  def profile(conn, _params) do
    subscriber = Pow.Plug.current_user(conn) |> check_if_subscriber_exists()

    render(conn, "profile.html", subscriber: subscriber)
  end

  def profile_delete_confirmation(conn, _params) do
    render(conn, "profile_delete_confirmation.html")
  end

  defp check_if_subscriber_exists(user) do
    # Check is subscriber email already exists.
    IO.inspect user
    IO.inspect user.email
    case Account.get_subscriber_email(user.email) do
      nil ->
        # If subscriber does not exist, create new subscriber
        case Account.create_subscriber(%{ subscriber_email: user.email, user_id: user.id }) do
          # Return created subscriber
          {:ok, subscriber} -> subscriber
          {:error, error} -> IO.inspect "Could not create subscriber"
        end

      # If email already exists.
      subscriber -> 
        IO.inspect "sub"
        # Check if user_id is same as user.id
        if subscriber.user_id != user.id do 
          IO.inspect "not user"
          # If not the same, then update
          Account.update_subscriber(subscriber, %{user_id: user.id})
        else
          IO.inspect "not use 2r"
          # Otherwise return original subscriber value
          subscriber
        end
    end
  end
end
