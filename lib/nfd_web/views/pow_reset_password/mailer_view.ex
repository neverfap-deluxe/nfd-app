defmodule NfdWeb.PowResetPassword.MailerView do
  use NfdWeb, :mailer_view

  def subject(:reset_password, _assigns), do: "Reset password link"
end
