defmodule NfdWeb.SubscriptionController do
  use NfdWeb, :controller

  alias Nfd.Content
  alias Nfd.Account

  alias NfdWeb.EmailSubscription

  def add_subscription_func(conn, %{"email" => email, "matrix_element" => matrix_element}) do
    case EmailSubscription.validate_matrix_element(matrix_element) do 
      true ->
        case Account.get_subscriber_email(email) do 
          nil ->
            case Account.create_subscriber(%{subscriber_email: email}) do
              {:ok, subscriber} ->
                EmailSubscription.send_email_subscription(subscriber, matrix_element)
                course_name = EmailSubscription.course_name_from_matrix(matrix_element)
                render(conn, "confirm_subscription_page.html", course_name: course_name)

              {:error, changeset} ->
                error_message = "Could not create subscriber."
                render(conn, "failed_subscription_page.html", error_message: error_message)
            end

          subscriber ->
            EmailSubscription.send_email_subscription(subscriber, matrix_element)
            course_name = EmailSubscription.course_name_from_matrix(matrix_element)
            render(conn, "confirm_subscription_page.html", course_name: course_name)
        end
      nil ->
        error_message = "Matrix element is invalid."
        render(conn, "unsubscribe_subscription_page.html", error_message: error_message)
    end
  end

  def confirm_subscription_func(conn, %{"email" => email, "matrix_element" => matrix_element}) do
    case EmailSubscription.validate_matrix_element(matrix_element) do 
      true -> 
        case Account.get_subscriber_email(email) do
          nil ->
            error_message = "It's not possible to confirm the subscription of a subscriber that doesn't exist."
            render(conn, "failed_subscription_page.html", error_message: error_message)

          subscriber ->
            EmailSubscription.update_subscription(subscriber, matrix_element)
            course_name = EmailSubscription.course_name_from_matrix(matrix_element)
            render(conn, "success_subscription_page.html", course_name: course_name)
        end
      nil ->
        error_message = "Matrix element is invalid."
        render(conn, "unsubscribe_subscription_page.html", error_message: error_message)
    end
  end

  def unsubscribe_func(conn, %{"email" => email, "matrix_element" => matrix_element}) do
    case EmailSubscription.validate_matrix_element(matrix_element) do 
      true -> 
        case Account.get_subscriber_email(email) do
          nil ->
            error_message = "Unable to unsubscribe a subscriber that doesn't exist."
            render(conn, "unsubscribe_subscription_page.html", error_message: error_message)
          
          subscriber ->
            course_name = EmailSubscription.course_name_from_matrix(matrix_element)
            render(conn, "unsubscribe_subscription_page.html", course_name: course_name)
        end
      nil -> 
        error_message = "Matrix element is invalid."
        render(conn, "unsubscribe_subscription_page.html", error_message: error_message)
    end
  end

  def change_subscription_general_func(conn, %{"subscribed" => subscribed, "user_id" => user_id}) do
    subscriber = 
    case Account.get_subscriber_user_id!(user_id) do 
      {:ok, subscriber} ->
        if subscribed == "true", do: Account.update_subscriber(subscriber, %{ subscribed: false })
        if subscribed == "false", do: Account.update_subscriber(subscriber, %{ subscribed: true }) 
        redirect(conn, to: Routes.dashboard_path(conn, :dashboard))
    
      {:error, subscriber} -> 
        redirect(conn, to: Routes.dashboard_path(conn, :dashboard))
    end
  end

end
