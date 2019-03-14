defmodule NfdWeb.SubscriptionController do
  use NfdWeb, :controller

  alias Nfd.Content
  alias Nfd.Account

  alias NfdWeb.EmailMatrixTransform
  alias NfdWeb.EmailSend

  def add_subscription_func(conn, %{"subscriber" => subscriber}) do
    multiple_matrix = subscriber["multiple_matrix"]
    main_matrix = subscriber["main_matrix"]
    email = subscriber["subscriber_email"]

    case EmailMatrixTransform.validate_multiple_matrix(multiple_matrix) do
      true -> add_subscription_create_user(email, multiple_matrix, main_matrix, conn)
      [true, true] -> add_subscription_create_user(email, multiple_matrix, main_matrix, conn)
      _ -> render_failure_page("Matrix element is invalid.", conn)
      [_, _] -> render_failure_page("Matrix element is invalid.", conn)
    end
  end

  defp add_subscription_create_user(email, multiple_matrix, main_matrix, conn) do
    case Account.get_subscriber_email(email) do
      nil ->
        case Account.create_subscriber(%{subscriber_email: email}) do
          {:ok, subscriber} ->
            # TODO: Check if user is already subscribed
            # check_if_subscriber_is_already_subscribed(subscriber, main_matrix)
            course_name = EmailMatrixTransform.course_name_from_matrix(main_matrix)
            EmailSend.send_email_subscription(subscriber, multiple_matrix, main_matrix)
            render(conn, "confirm_subscription_page.html", course_name: course_name)

          {:error, changeset} -> render_failure_page("Could not create subscriber.", conn)
        end

      subscriber ->
        course_name = EmailMatrixTransform.course_name_from_matrix(main_matrix)
        EmailSend.send_email_subscription(subscriber, multiple_matrix, main_matrix)
        render(conn, "confirm_subscription_page.html", course_name: course_name)
    end
  end

  def confirm_subscription_func(conn, %{"email" => email, "multiple_matrix" => multiple_matrix, "main_matrix" => main_matrix}) do
    case EmailMatrixTransform.validate_multiple_matrix(multiple_matrix) do 
      true -> confirm_subscription_update_subscription(email, multiple_matrix, main_matrix, conn)
      [true, true] -> confirm_subscription_update_subscription(email, multiple_matrix, main_matrix, conn)
      _ -> render_failure_page("Matrix element is invalid.", conn)
      [_, _] -> render_failure_page("Matrix element is invalid.", conn)
    end
  end

  defp confirm_subscription_update_subscription(email, multiple_matrix, main_matrix, conn) do 
    case Account.get_subscriber_email(email) do
      nil -> render_failure_page("It's not possible to confirm the subscription of a subscriber that doesn't exist.", conn)
      subscriber ->
        # Send day 0 email, 
        EmailMatrixTransform.update_subscription(subscriber, multiple_matrix)
        EmailSend.send_day_0_email(subscriber, main_matrix)
        course_name = EmailMatrixTransform.course_name_from_matrix(main_matrix)
        render(conn, "success_subscription_page.html", course_name: course_name)
    end
  end

  def unsubscribe_func(conn, %{"email" => email, "main_matrix" => main_matrix}) do
    case EmailMatrixTransform.validate_multiple_matrix(main_matrix) do 
      true -> unsubscribe_user(email, main_matrix, conn)
      [true, true] -> unsubscribe_user(email, main_matrix, conn)
      _ -> render_failure_page("Matrix element is invalid.", conn)
      [_, _] -> render_failure_page("Matrix element is invalid.", conn)
    end
  end

  defp unsubscribe_user(email, main_matrix, conn) do 
    case Account.get_subscriber_email(email) do
      nil -> render_failure_page("Unable to unsubscribe a subscriber that doesn't exist.", conn)
      subscriber ->
        # TODO: Function which actually unsubscribers the user
        EmailMatrixTransform.unsubscribe_subscriber(subscriber, main_matrix)
        course_name = EmailMatrixTransform.course_name_from_matrix(main_matrix)
        render(conn, "unsubscribe_subscription_page.html", course_name: course_name)
    end  
  end

  defp render_failure_page(error_message, conn) do 
    render(conn, "failed_subscription_page.html", error_message: error_message)
  end

  def change_subscription_general_func(conn, %{"subscribed" => subscribed, "user_id" => user_id}) do
    case Account.get_subscriber_user_id(user_id) do
      nil ->
        redirect(conn, to: Routes.dashboard_path(conn, :dashboard))

      subscriber ->
        if subscribed == "true", do: Account.update_subscriber(subscriber, %{ subscribed: false })
        if subscribed == "false", do: Account.update_subscriber(subscriber, %{ subscribed: true }) 
        redirect(conn, to: Routes.dashboard_path(conn, :dashboard))
    end
  end

  def reset_subscription_to_different_day do 

  end

end
