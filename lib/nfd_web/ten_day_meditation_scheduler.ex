defmodule NfdWeb.TenDayMeditationScheduler do
  use Swoosh.Mailer, otp_app: :nfd
  use Phoenix.Swoosh, view: NfdWeb.TenDayMeditationView, layout: {NfdWeb.LayoutView, :email}
  import Swoosh.Email

  require Logger

  def day_challenge_logic(subject, template, day_number) do
    # subscribers
    #   |> # get only subscribers that  day_number

    # Enum.each(subscribers, fn(subscriber) -> 
    #   if (subscriber.is_subscribed_twenty_eight_day_challenge) do

    #     email = cast(subscriber, subject, template)
    #     process(email)
        
    #     if (twenty_eight_day_challenge_count == 29) do
    #       #  set is_subscribed_twenty_eight_day_challenge to false
    #     else
    #       # otherwise, increment twenty_eight_day_challenge_count
    #       twenty_eight_day_challenge_count
    #     end
    #   end
    # end)
  end

  def run_all do
    day_challenge_logic("", "", 0)
    day_challenge_logic("", "", 1)
    day_challenge_logic("", "", 2)
    day_challenge_logic("", "", 3)
    day_challenge_logic("", "", 4)
    day_challenge_logic("", "", 5)
    day_challenge_logic("", "", 6)
    day_challenge_logic("", "", 7)
    day_challenge_logic("", "", 8)
    day_challenge_logic("", "", 9)
    day_challenge_logic("", "", 10)
  end

  def cast(%{user: user, subject: subject, template: template}) do
    %Swoosh.Email{}
      |> to({"namewayne", user.email})
      |> from({"NeverFap Deluxe", "no-reply@neverfapdeluxe.com"})
      |> subject(subject)
      |> render_body(template, %{username: user.username})

      # |> html_body(html)
      # |> text_body(text)
  end

  def process(email) do
    Nfd.SwooshMailer.deliver(email)

    Logger.debug("Twenty Eight Day Challenge E-mail sent: #{inspect email}")
  end
end
