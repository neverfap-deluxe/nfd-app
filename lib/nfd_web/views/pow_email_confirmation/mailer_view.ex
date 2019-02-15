defmodule NfdWeb.PowEmailConfirmation.MailerView do
  use NfdWeb, :mailer_view

  def subject(:email_confirmation, _assigns), do: "Confirm your email address"
end
