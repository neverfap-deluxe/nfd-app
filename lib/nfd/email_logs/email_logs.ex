defmodule Nfd.EmailLogs do 
  use Swoosh.Mailer, otp_app: :nfd
  use Phoenix.Swoosh, 
    view: NfdWeb.SubscriptionTemplateView, 
    layout: {NfdWeb.LayoutView, :email}

  import Swoosh.Email

  require Logger

  def cast_scheduler(%{subscriber: subscriber, subject: subject, template: template}) do
    # TODO: Put in variables into template
    %Swoosh.Email{}
      |> to(subscriber.subscriber_email)
      |> from({"NeverFap Deluxe", "neverfapdeluxe@gmail.com"})
      |> subject(subject)
      |> render_body(template, %{})
  end

  def cast_log(email, message) do
    Nfd.SwooshMailer.deliver(email)

    Logger.debug(message)
  end
end
