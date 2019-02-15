defmodule NfdWeb.PowMailer do
  use Pow.Phoenix.Mailer
  use Swoosh.Mailer, otp_app: :my_app

  require Logger

  import Swoosh.Email

  def cast(%{user: user, subject: subject, text: text, html: html}) do
    %Swoosh.Email{}
    |> to({"", user.email})
    |> from({"NeverFap Deluxe", "admin@neverfapdeluxe.com"})
    |> subject(subject)
    |> html_body(html)
    |> text_body(text)
  end

  def process(email) do
    deliver(email)
  end


  # def cast(%{user: user, subject: subject, text: text, html: html, assigns: _assigns}) do
  #   # Build email struct to be used in `process/1`

  #   %{to: user.email, subject: subject, text: text, html: html}
  # end

  # def process(email) do
  #   # Send email

  #   Logger.debug("E-mail sent: #{inspect email}")
  # end
end
