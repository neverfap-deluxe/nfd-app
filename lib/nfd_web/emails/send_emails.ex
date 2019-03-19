defmodule NfdWeb.SendEmails do
  use Swoosh.Mailer, otp_app: :nfd
  use Phoenix.Swoosh, 
    view: NfdWeb.SubscriptionTemplateView, 
    layout: {NfdWeb.LayoutView, :email}

  import Swoosh.Email

  alias Nfd.Account

  alias NfdWeb.SevenDayKickstarterScheduler
  # alias NfdWeb.TenDayMeditationScheduler
  # alias NfdWeb.TwentyEightDayAwarenessScheduler

  alias NfdWeb.EmailMatrixTransform

  require Logger

  # Email Schedule Logic
  def send_email_subscription(subscriber, multiple_matrix, main_matrix) do
    url = EmailMatrixTransform.subscription_confirmation_url_from_matrix(subscriber.subscriber_email, multiple_matrix, main_matrix)
    unsubscribe_url = EmailMatrixTransform.generate_unsubscribe_url(subscriber.subscriber_email,main_matrix)
    course_name = EmailMatrixTransform.course_name_from_matrix(main_matrix)

    cast_subscriber(
      subscriber,
      url,
      unsubscribe_url,
      course_name,
      "Confirm your subscription",
      "template_email_subscription_confirmation.html"
    ) |> process("Confirm your subscription E-mail sent: " <> subscriber.subscriber_email)
  end

  def send_day_0_email(subscriber, main_matrix) do
    case String.split(main_matrix, "h") do
      ["0", _] -> 
        # TODO: Welcome email for general newsletter.
        nil
      ["1", _] -> 
        NfdWeb.SevenDayKickstarterScheduler.run(0)
        NfdWeb.SevenDayKickstarterScheduler.update(subscriber, 0)
      # ["2", _] -> 
      #   NfdWeb.TenDayMeditationScheduler.run(0)
      #   NfdWeb.TenDayMeditationScheduler.update(subscriber, 0)
      # ["3", _] -> 
      #   NfdWeb.TwentyEightDayAwarenessScheduler.run(0)
      #   NfdWeb.TwentyEightDayAwarenessScheduler.update(subscriber, 0)
      # ["4", _] -> 
      # ["5", _] -> 
      # ["6", _] -> 
    end
  end

  def email_scheduler() do
    subscribers = Account.list_subscribers_campaign()
    Enum.each(subscribers, fn(subscriber) ->
      email_scheduler_logic(7, subscriber, subscriber.seven_day_kickstarter_subscribed, subscriber.seven_day_kickstarter_count)
      # email_scheduler_logic(10, subscriber, subscriber.ten_day_meditation_subscribed, subscriber.ten_day_meditation_count)
      # email_scheduler_logic(28, subscriber, subscriber.twenty_eight_day_awareness_subscribed, subscriber.twenty_eight_day_awareness_count)
    end)
  end

  def email_scheduler_logic(type, subscriber, is_subscribed, day_count) do
    if (is_subscribed) do
      { subject, template } =
        case type do 
          7 -> SevenDayKickstarterScheduler.run(day_count)
          # 10 -> TenDayMeditationScheduler.run(day_count)
          # 28 -> TwentyEightDayAwarenessScheduler.run(day_count)
        end 

      case type do 
        7 -> cast_scheduler({subscriber, subject, template}) |> process("Seven Day NeverFap Deluxe Kickstarter - Day #{day_count} E-mail sent: " <> subscriber.email)
        # 10 -> cast_scheduler({subscriber, subject, template}) |> process("Ten Day Meditation Primer - Day #{day_count} E-mail sent: " <> subscriber.email)
        # 28 -> cast_scheduler({subscriber, subject, template}) |> process("Twenty Eight Day Challenge - Day #{day_count} E-mail sent: " <> subscriber.email)
      end 

      case type do 
        7 -> SevenDayKickstarterScheduler.update(subscriber, day_count)
        # 10 -> TenDayMeditationScheduler.update(subscriber, day_count)
        # 28 -> TwentyEightDayAwarenessScheduler.update(subscriber, day_count)
      end 
    end
  end

  def cast_scheduler(%{subscriber: subscriber, subject: subject, template: template}) do
    # TODO: Put in variables into template
    %Swoosh.Email{}
      |> to(subscriber.subscriber_email)
      |> from({"NeverFap Deluxe", "neverfapdeluxe@gmail.com"})
      |> subject(subject)
      |> render_body(template, %{})
  end

  def cast_subscriber(subscriber, url, unsubscribe_url, course_name, subject, template) do
    %Swoosh.Email{}
      |> to(subscriber.subscriber_email)
      |> from({"NeverFap Deluxe", "neverfapdeluxe@gmail.com"})
      |> subject(subject)
      |> render_body(template, %{url: url, unsubscribe_url: unsubscribe_url, course_name: course_name})
  end

  def process(email, message) do
    Nfd.SwooshMailer.deliver(email)
    Logger.debug(message)
  end
end
