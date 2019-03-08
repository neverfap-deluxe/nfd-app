defmodule NfdWeb.EmailScheduler do
  use Swoosh.Mailer, otp_app: :nfd
  use Phoenix.Swoosh, view: NfdWeb.TenDayMeditationEmailTemplateView, layout: {NfdWeb.LayoutView, :email}
  import Swoosh.Email

  alias Nfd.Account

  alias NfdWeb.SevenDayKickstarterScheduler
  alias NfdWeb.TenDayMeditationScheduler
  alias NfdWeb.TwentyEightDayAwarenessScheduler

  require Logger

  def email_scheduler() do
    subscribers = Account.list_subscribers_campaign()
    Enum.each(subscribers, fn(subscriber) ->
      email_scheduler_logic(7, subscriber, subscriber.seven_day_kickstarter_subscribed, subscriber.seven_day_kickstarter_count)
      email_scheduler_logic(10, subscriber, subscriber.ten_day_meditation_subscribed, subscriber.ten_day_meditation_count)
      email_scheduler_logic(28, subscriber, subscriber.twenty_eight_day_awareness_subscribed, subscriber.twenty_eight_day_awareness_count)
    end)
  end

  def email_scheduler_logic(type, subscriber, is_subscribed, day_count) do
    if (is_subscribed) do
      { subject, template } =
        case type do 
          7 -> SevenDayKickstarterScheduler.run(day_count)
          10 -> TenDayMeditationScheduler.run(day_count)
          28 -> TwentyEightDayAwarenessScheduler.run(day_count)
        end 

      case type do 
        7 -> cast({subscriber, subject, template}) |> process("Seven Day NeverFap Deluxe Kickstarter - Day #{day_count} E-mail sent: " <> subscriber.email)
        10 -> cast({subscriber, subject, template}) |> process("Ten Day Meditation Primer - Day #{day_count} E-mail sent: " <> subscriber.email)
        28 -> cast({subscriber, subject, template}) |> process("Twenty Eight Day Challenge - Day #{day_count} E-mail sent: " <> subscriber.email)
      end 

      case type do 
        7 -> SevenDayKickstarterScheduler.update(subscriber, day_count)
        10 -> TenDayMeditationScheduler.update(subscriber, day_count)
        28 -> TwentyEightDayAwarenessScheduler.update(subscriber, day_count)
      end 
    end
  end

  def cast(%{subscriber: subscriber, subject: subject, template: template}) do
    %Swoosh.Email{}
      |> to(subscriber.subscriber_email)
      |> from({"NeverFap Deluxe", "neverfapdeluxe@gmail.com"})
      |> subject(subject)
      |> render_body(template)
  end

  def process(email, message) do
    Nfd.SwooshMailer.deliver(email)

    Logger.debug(message)
  end
end
