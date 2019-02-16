defmodule NfdWeb.PowMailer do
  use Pow.Phoenix.Mailer

  require Logger

  import Swoosh.Email

  def cast(%{user: user, subject: subject, text: text, html: html}) do
    # Build email struct to be used in `process/1`

    %Swoosh.Email{}
    |> to({"yolololo", user.email})
    |> from({"NeverFap Deluxe", "admin@neverfapdeluxe.com"})
    |> subject(subject)
    |> html_body(html)
    |> text_body(text)
  end

  def process(email) do
    Nfd.SwooshMailer.deliver(email)

    Logger.debug("E-mail sent: #{inspect email}")
  end  
end
