defmodule NfdWeb.SubscriptionController do
  use NfdWeb, :controller

  alias Nfd.Content
  alias Nfd.Account
  alias Nfd.EmailLogs

  alias NfdWeb.EmailMatrixTransform
  alias NfdWeb.SendEmails

  def add_subscription_func(conn, %{"subscriber" => subscriber}) do
    case EmailMatrixTransform.validate_multiple_matrix(subscriber["multiple_matrix"]) do
      [true] -> add_subscription_create_user(subscriber["subscriber_email"], subscriber["multiple_matrix"], subscriber["main_matrix"], conn)
      [true, true] -> add_subscription_create_user(subscriber["subscriber_email"], subscriber["multiple_matrix"], subscriber["main_matrix"], conn)
      [_] -> render_failure_page("Matrix element is invalid.", conn)
      [_, _] -> render_failure_page("Matrix element is invalid.", conn)
    end
  end

  defp add_subscription_create_user(email, multiple_matrix, main_matrix, conn) do
    course_name = EmailMatrixTransform.generate_course_name_from_matrix(main_matrix)

    case Account.get_subscriber_email(email) do
      nil ->
        case Account.create_subscriber(%{subscriber_email: email}) do
          {:ok, subscriber} ->
            EmailLogs.new_subscriber_email_log(email, course_name)
            case EmailMatrixTransform.validate_subscriber_is_already_subscribed(subscriber, main_matrix) do 
              true -> 
                EmailLogs.error_email_log("#{email} - It appears user tried to subscribe to a course they were already subscribed to - add_subscription_create_user - subscription_controller.")
                render_failure_page("It appears you're already subscribed to #{course_name}!", conn)
              false ->
                SendEmails.send_email_subscription(subscriber, multiple_matrix, main_matrix)
                render(conn, "confirm_subscription_page.html", course_name: course_name)    
            end

          {:error, changeset} -> 
            EmailLogs.error_email_log("#{email} - Could not create subscriber when adding new subscription - add_subscription_create_user - subscription_controller.")
            render_failure_page("Could not create subscriber.", conn)
        end

      subscriber ->
        SendEmails.send_email_subscription(subscriber, multiple_matrix, main_matrix)
        render(conn, "confirm_subscription_page.html", course_name: course_name)
    end
  end

  def confirm_subscription_func(conn, %{"email" => email, "multiple_matrix" => multiple_matrix, "main_matrix" => main_matrix}) do
    case EmailMatrixTransform.validate_multiple_matrix(multiple_matrix) do 
      [true] -> confirm_subscription_update_subscription(email, multiple_matrix, main_matrix, conn)
      [true, true] -> confirm_subscription_update_subscription(email, multiple_matrix, main_matrix, conn)
      [_] -> render_failure_page("Matrix element is invalid.", conn)
      [_, _] -> render_failure_page("Matrix element is invalid.", conn)
    end
  end

  defp confirm_subscription_update_subscription(email, multiple_matrix, main_matrix, conn) do 
    course_name = EmailMatrixTransform.generate_course_name_from_matrix(main_matrix)

    case Account.get_subscriber_email(email) do
      nil -> 
        EmailLogs.error_email_log("#{email} - Cannot confirm the subscription of a subscriber that doesn't exist - confirm_subscription_update_subscription - subscription_controller.")        
        render_failure_page("It's not possible to confirm the subscription of a subscriber that doesn't exist.", conn)
      subscriber ->
        case EmailMatrixTransform.update_subscription(subscriber, multiple_matrix) do 
          [false] ->
            EmailLogs.error_email_log("#{email} - Would not update subscriber for one - confirm_subscription_update_subscription - subscription_controller.")        
            render_failure_page("The system (for some weird reason, since this should never happen) decided that it could not process your subscription and subscribe you to this course.", conn)
          [x, y] when x == false or y == false -> 
            EmailLogs.error_email_log("#{email} - Would not update subscriber for both - confirm_subscription_update_subscription - subscription_controller.")        
            render_failure_page("The system (for some weird reason, since this should never happen) decided that it could not process your subscription and subscribe you to this course.", conn)
          [updated_subscriber] ->
            SendEmails.send_day_0_email(updated_subscriber, main_matrix)
            render(conn, "success_subscription_page.html", course_name: course_name)  

          # NOTE: The second matrix is always the main one, therefore y is the relevant updated_subscriber
          [_general_subscriber, updated_subscriber] ->
            SendEmails.send_day_0_email(updated_subscriber, main_matrix)
            render(conn, "success_subscription_page.html", course_name: course_name)  
        end
    end
  end

  def unsubscribe_func(conn, %{"email" => email, "main_matrix" => main_matrix}) do
    IO.inspect EmailMatrixTransform.validate_multiple_matrix(main_matrix)

    case EmailMatrixTransform.validate_multiple_matrix(main_matrix) do 
      [true] -> unsubscribe_user(email, main_matrix, conn)
      [true, true] -> unsubscribe_user(email, main_matrix, conn)
      [_] -> render_failure_page("Matrix element is invalid.", conn)
      [_, _] -> render_failure_page("Matrix element is invalid.", conn)
    end
  end

  defp unsubscribe_user(email, main_matrix, conn) do 
    course_name = EmailMatrixTransform.generate_course_name_from_matrix(main_matrix)
    case Account.get_subscriber_email(email) do
      nil -> 
        EmailLogs.error_email_log("#{email} - Unable to unsubscribe a subscriber that doesn't exist - unsubscribe_user - subscription_controller.")        
        render_failure_page("Unable to unsubscribe a subscriber that doesn't exist.", conn)
      subscriber ->
        EmailMatrixTransform.unsubscribe_subscriber(subscriber, main_matrix)
        if course_name == "General Newsletter" do
          render(conn, "unsubscribe_general_subscription_page.html")          
        else 
          render(conn, "unsubscribe_course_subscription_page.html", course_name: course_name)
        end
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

  # def reset_subscription_to_different_day do 

  # end

end
