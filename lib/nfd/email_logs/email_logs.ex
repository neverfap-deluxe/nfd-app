defmodule Nfd.EmailLogs do
  use Swoosh.Mailer, otp_app: :nfd
  import Swoosh.Email

  def pow_email_log(subject, email) do
    cast_log(subject <> " - " <> email, subject <> " - " <> email) |> process_log()
  end

  def new_user_email_log(email) do
    message = "New User Created: #{email}"
    cast_log(message, message) |> process_log()
  end

  def new_subscriber_email_log(email, course_name) do
    message = "New Subscriber: #{email} for #{course_name}"
    cast_log(message, message) |> process_log()
  end

  def new_unsubscribe_email_log(email, course_name) do
    message = "User unsubscribed: #{email} for #{course_name}"
    cast_log(message, message) |> process_log()
  end

  def new_contact_form_email(name, email, message) do
    cast_log("New Contact Form Submission: #{name} - #{email}", "Email: " <> email <> ", Message: " <> message) |> process_log()
  end

  def new_comment_form_email(name, email, message, referer_value, comment_id, host) do
    delete_comment_url = "#{host}/delete_comment?comment_id=#{comment_id}&delete_comment_secret=#{System.get_env("DELETE_COMMENT_SECRET")} "
    cast_log("New Comment Form Submission: " <> name <> " - " <> email, "Email: " <> email <> "\n, Message: " <> message <> ", Referer: " <> referer_value <> ", Delete Url: " <> delete_comment_url) |> process_log()
  end

  def user_deleted_email(email) do
    cast_log("User Deleted Themselves: " <> email, "User Deleted Themselves: " <> email) |> process_log()
  end

  def success_email_log(message) do
    cast_log("Success", message) |> process_log()
  end

  def error_email_log(message) do
    cast_log("Error", message) |> process_log()
  end

  def cast_log(subject, message) do
    %Swoosh.Email{}
      |> to({"Julius Reade", "julius.reade@gmail.com"})
      |> from({"NeverFap Deluxe", "neverfapdeluxe@gmail.com"})
      |> subject(subject)
      |> text_body(message)
  end

  def process_log(email) do
    Nfd.SwooshMailer.deliver(email)
  end
end
