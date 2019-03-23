defmodule NfdWeb.SubscriptionController do
  use NfdWeb, :controller

  alias Nfd.Account
  alias Nfd.EmailLogs

  alias NfdWeb.Emails
  alias Util.Email


  # Add Subscription

  def add_subscription_validate_matrix(conn, %{"subscriber" => subscriber}) do
    case Email.validate_multiple_matrix(subscriber["multiple_matrix"]) do
      true -> add_subscription_get_subscriber(conn, subscriber["subscriber_email"], subscriber["multiple_matrix"], subscriber["main_matrix"])
      false -> render_failure_page(:add_subscription_validate_matrix, conn, nil, nil, nil)
    end
  end

  defp add_subscription_get_subscriber(conn, subscriber_email, multiple_matrix, main_matrix) do
    case Account.get_subscriber_email(subscriber_email) do
      nil -> add_subscription_create_subscriber(conn, subscriber_email, multiple_matrix, main_matrix)
      subscriber -> add_subscription_check_if_already_subscribed(conn, subscriber.subscriber_email, multiple_matrix, main_matrix)
    end
  end

  defp add_subscription_create_subscriber(conn, subscriber_email, multiple_matrix, main_matrix) do 
    case Account.create_subscriber(%{subscriber_email: subscriber_email}) do
      {:ok, subscriber_email} -> add_subscription_check_if_already_subscribed(conn, subscriber_email, multiple_matrix, main_matrix)
      {:error, changeset} -> render_failure_page(:add_subscription_create_subscriber, conn, subscriber_email, nil, nil)
    end
  end

  defp add_subscription_check_if_already_subscribed(conn, subscriber_email, multiple_matrix, main_matrix) do
    subscriber = Account.get_subscriber_email(subscriber_email)
    course_name = Email.main_matrix_to_type(main_matrix) |> Email.generate_course_name_from_type()
    case Email.validate_subscriber_is_already_subscribed(subscriber, main_matrix) do 
      true -> render_failure_page(:add_subscription_check_if_already_subscribed, conn, subscriber.subscriber_email, course_name, nil)
      false -> add_subscription_subscriber_does_not_exist(conn, subscriber.subscriber_email, multiple_matrix, main_matrix, course_name) 
    end
  end

  defp add_subscription_subscriber_does_not_exist(conn, subscriber_email, multiple_matrix, main_matrix, course_name) do 
    Emails.cast_confirmation_url(
      subscriber_email, 
      Email.generate_confirmation_url(subscriber_email, multiple_matrix, main_matrix),
      Email.generate_unsubscribe_url(main_matrix, subscriber_email),
      course_name,
      "Confirm Your #{course_name} Subscription",
      "template_email_subscription_confirmation.html"
    ) |> Emails.process("Confirm your subscription E-mail sent: " <> subscriber_email)

    render(conn, "confirm_subscription_page.html", course_name: course_name)
  end



  # Confirm Subscription

  def confirm_subscription_validate_matrix(conn, %{"subscriber_email" => subscriber_email, "multiple_matrix" => multiple_matrix, "main_matrix" => main_matrix}) do
    case Email.validate_multiple_matrix(multiple_matrix) do 
      true -> confirm_subscription_get_subscriber(conn, subscriber_email, multiple_matrix, main_matrix, conn)
      false -> render_failure_page(:confirm_subscription_validate_matrix, conn, nil, nil, nil)
    end
  end

  defp confirm_subscription_get_subscriber(conn, subscriber_email, multiple_matrix, main_matrix, conn) do 
    case Account.get_subscriber_email(subscriber_email) do
      nil -> render_failure_page(:confirm_subscription_get_subscriber, conn, subscriber_email, nil, nil)        
      subscriber -> confirm_subscription_update_subscription(conn, subscriber, multiple_matrix, main_matrix, conn)
    end
  end

  defp confirm_subscription_update_subscription(conn, subscriber, multiple_matrix, main_matrix, conn) do 
    { general_type, kickstarter_type, meditation_primer_type, awareness_challenge_type} = Email.generate_course_types()
    
    update_subscription_object = Enum.map(String.split(multiple_matrix, "-"), fn(main_matrix) ->
      # NOTE: If there is no multiple, then it will just be ["0", "1"]
      case Email.main_matrix_to_type_and_action(main_matrix) do
        { general_type, action } -> confirm_subscription_action(subscriber, action, general_type)
        { kickstarter_type, action } -> confirm_subscription_action(subscriber, action, kickstarter_type)
        { meditation_primer_type, action } -> confirm_subscription_action(subscriber, action, meditation_primer_type)
        { awareness_challenge_type, action } -> confirm_subscription_action(subscriber, action, awareness_challenge_type)
      end
    end)

    case update_subscription_object do
      [false] -> render_failure_page(:confirm_subscription_update_subscription, conn, subscriber.subscriber_email, nil, nil)
      [x, y] when x == false or y == false -> render_failure_page(:confirm_subscription_update_subscription, conn, subscriber.subscriber_email, nil, nil)
      [updated_subscriber] -> confirm_subscription_success(conn, updated_subscriber, main_matrix)
      [_general_subscriber, updated_subscriber] -> confirm_subscription_success(conn, updated_subscriber, main_matrix)
    end
  end

  defp confirm_subscription_action(subscriber, action, type) do
    cond do
       action == :nothing -> false
       action == :subscribe -> confirm_subscription_action_subscribe(subscriber, type)
       action == :unsubscribe -> confirm_subscription_action_unsubscribe(subscriber, type)
    end
  end

  defp confirm_subscription_action_subscribe(subscriber, type) do
    {_, subscribed_property} = Email.type_to_subscriber_properties(type)

    case Account.update_subscriber(subscriber, %{ subscribed_property => true }) do
      {:ok, updated_subscriber} -> updated_subscriber
      {:error, changeset} -> confirm_subscription_action_failure(subscriber.subscriber_email, "subscribe")
    end
  end

  defp confirm_subscription_action_unsubscribe(subscriber, type) do
    {_, subscribed_property} = Email.type_to_subscriber_properties(type)
    case Account.update_subscriber(subscriber, %{ subscribed_property => false }) do
      {:ok, updated_subscriber} -> updated_subscriber
      {:error, changeset} -> confirm_subscription_action_failure(subscriber.subscriber_email, "unsubscribe")
    end
  end

  defp confirm_subscription_action_failure(subscriber_email, relevant_text) do
    EmailLogs.error_email_log("#{subscriber_email} - Would not #{relevant_text} subscriber - :confirm_subscription_action_failure.")        
    false
  end

  defp confirm_subscription_success(conn, updated_subscriber, main_matrix) do 
    course_name = Email.main_matrix_to_type(main_matrix) |> Email.generate_course_name_from_type()
    Emails.send_day_0_email(updated_subscriber, main_matrix)
    render(conn, "success_subscription_page.html", course_name: course_name)  
  end



  # Unsubscribe Subscription

  def unsubscribe_validate_matrix(conn, %{"subscriber_email" => subscriber_email, "main_matrix" => main_matrix}) do
    case Email.validate_multiple_matrix(main_matrix) do 
      true -> unsubscribe_get_subscriber(conn, subscriber_email, main_matrix)
      false -> render_failure_page(:unsubscribe_validate_matrix, conn, nil, nil, nil)
    end
  end

  defp unsubscribe_get_subscriber(conn, subscriber_email, main_matrix) do 
    course_name = Email.main_matrix_to_type(main_matrix) |> Email.generate_course_name_from_type()

    case Account.get_subscriber_email(subscriber_email) do
      nil -> render_failure_page(:unsubscribe_get_subscriber, conn, subscriber_email, nil, nil)
      subscriber -> unsubscribe_subscriber(conn, subscriber, main_matrix)
    end  
  end

  def unsubscribe_subscriber(conn, subscriber, main_matrix) do
    course_name = Email.main_matrix_to_type(main_matrix) |> Email.generate_course_name_from_type()
    { general_type, kickstarter_type, meditation_primer_type, awareness_challenge_type} = Email.generate_course_types()
      
    case Email.main_matrix_to_type(main_matrix) do
      general_type -> unsubscribe_subscriber_action(conn, subscriber, general_type, course_name)
      kickstarter_type -> unsubscribe_subscriber_action(conn, subscriber, kickstarter_type, course_name)
      meditation_primer_type -> unsubscribe_subscriber_action(conn, subscriber, meditation_primer_type, course_name)
      awareness_challenge_type -> unsubscribe_subscriber_action(conn, subscriber, awareness_challenge_type, course_name)
    end
  end

  defp unsubscribe_subscriber_action(conn, subscriber, type, course_name) do
    {_, subscribed_property} = Email.type_to_subscriber_properties(type)

    case Account.update_subscriber(subscriber, %{ subscribed_property => false }) do
      {:ok, subscriber} -> unsubscribe_subscriber_action_success(conn, subscriber.subscriber_email, course_name)
      {:error, changeset} -> render_failure_page(:unsubscribe_subscriber_action, conn, subscriber.subscriber_email, nil, subscribed_property)
    end
  end

  defp unsubscribe_subscriber_action_success(conn, subscriber_email, course_name) do    
    EmailLogs.new_unsubscribe_email_log(subscriber_email, course_name)
    if course_name == "General Newsletter" do
      render(conn, "unsubscribe_general_subscription_page.html")          
    else 
      render(conn, "unsubscribe_course_subscription_page.html", course_name: course_name)
    end
  end



  # Error Handler

  defp render_failure_page(type, conn, subscriber_email, course_name, subscribed_property) do 
    { error_message, error_log_message } = 
      case type do 
        :add_subscription_validate_matrix -> { 
          "The subscription which has been processed is invalid.", 
          "Matrix Invalid. :add_subscription_validate_matrix."
        }
        :confirm_subscription_validate_matrix -> {
          "The subscription which has been processed is invalid.", 
          "Matrix Invalid. :confirm_subscription_validate_matrix."
        }
        :unsubscribe_validate_matrix -> {
          "The subscription which has been processed is invalid.", 
          "Matrix Invalid. :unsubscribe_validate_matrix."
        }

        :confirm_subscription_get_subscriber -> {
          "It's not possible to confirm the subscription of a subscriber that doesn't exist.",
          "#{subscriber_email} - Cannot confirm the subscription of a subscriber that doesn't exist - :confirm_subscription_get_subscriber."
        }
        :unsubscribe_get_subscriber -> {
          "Unable to unsubscribe a subscriber that doesn't exist.",
          "#{subscriber_email} - Unable to unsubscribe a subscriber that doesn't exist - :unsubscribe_get_subscriber."
        }

        :add_subscription_create_subscriber -> { 
          "Could not create subscriber. Sorry!", 
          "#{subscriber_email} - Could not create subscriber when adding new subscription - :add_subscription_create_subscriber."
        }
        :add_subscription_check_if_already_subscribed -> {
          "It appears you're already subscribed to #{course_name}!",
          "#{subscriber_email} - It appears user tried to subscribe to a course they were already subscribed to - :add_subscription_check_if_already_subscribed."
        }
        :confirm_subscription_update_subscription -> {
          "The system (for some weird reason, since this should never happen) decided that it could not process your subscription and subscribe you to this course.",
          "#{subscriber_email} - Would not update subscriber for one - :confirm_subscription_update_subscription.",
        }
        :unsubscribe_subscriber_action -> {
          "Unable to unsubscribe user",
          "#{subscriber_email} did not unsubscribe. #{subscribed_property} :unsubscribe_subscriber_action"
        }
      end

    EmailLogs.error_email_log(error_log_message)
    render(conn, "failed_subscription_page.html", error_message: error_message)
  end



  # Change subscription general

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
