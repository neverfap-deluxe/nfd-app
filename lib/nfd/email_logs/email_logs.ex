defmodule Nfd.EmailLogs do 
  use Swoosh.Mailer, otp_app: :nfd
  import Swoosh.Email

  def pow_email_log(subject, email) do 
    cast_log(subject <> " - " <> email, subject <> " - " <> email) |> process_log()
  end

  def new_user_email_log(email) do 
    cast_log("New User Created: " <> email, "New User Created: " <> email) |> process_log()
  end

  def new_subscriber_email_log(email, subscription) do 
    cast_log("New Subscriber: " <> email <> " for " <> subscription, "New Subscriber: " <> email <> " for " <> subscription) |> process_log()
  end

  def new_contact_form_email(name, email, message) do
    cast_log("New Contact Form Submission: " <> name <> " - " <> email, "Email: " <> email <> ", Message:" <> message) |> process_log()
  end

  def user_deleted_email(email) do
    cast_log("User Deleted Themselves: " <> email, "User Deleted Themselves: " <> email) |> process_log()
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
