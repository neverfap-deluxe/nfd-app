defmodule NfdWeb.PowMailer do
  use Pow.Phoenix.Mailer
  use Swoosh.Mailer, otp_app: :nfd

  import Swoosh.Email

  require Logger

  def cast(%{user: user, subject: subject, text: text, html: html}) do
    Nfd.EmailLogs.pow_email_log(subject, user.email)

    %Swoosh.Email{} 
      |> to({user.email, user.email}) # user.email
      |> from({"NeverFap Deluxe", "neverfapdeluxe@gmail.com"})
      |> subject(subject)
      |> html_body(html)
      |> text_body(text)
  end

  def process(email) do
    Nfd.SwooshMailer.deliver(email)
    Logger.debug("E-mail sent")
  end  
end
