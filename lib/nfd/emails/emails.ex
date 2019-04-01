defmodule Nfd.Emails do
  use Swoosh.Mailer, otp_app: :nfd
  use Phoenix.Swoosh, 
    view: NfdWeb.SubscriptionTemplateView, 
    layout: {NfdWeb.LayoutView, :email}

  import Swoosh.Email

  alias Nfd.Account
  alias Nfd.EmailTemplates
  alias Nfd.EmailLogs
  alias Nfd.Meta

  require Logger

  # Email Schedule Logic

  def send_day_0_email(subscriber, main_matrix) do
    { general_type, kickstarter_type, meditation_primer_type, awareness_challenge_type} = Nfd.Util.Email.generate_course_types()
    type = Nfd.Util.Email.main_matrix_to_type(main_matrix)

    case type do
      # TODO: Welcome email for general newsletter.
      ^general_type -> nil
      ^kickstarter_type -> email_scheduler_logic(kickstarter_type, subscriber, subscriber.seven_day_kickstarter_subscribed, 0)
      ^meditation_primer_type -> email_scheduler_logic(meditation_primer_type, subscriber, subscriber.ten_day_meditation_subscribed, 0)
      ^awareness_challenge_type -> email_scheduler_logic(awareness_challenge_type, subscriber, subscriber.twenty_eight_day_awareness_subscribed, 0)
    end
  end

  # NOTE: We don't need to worry about co-ordinating Day 0, because it will just be a general information email :)
  def email_scheduler do
    Account.list_subscribers_campaign()
      |> Enum.each(fn(subscriber) -> 
        email_scheduler_logic(Application.get_env(:nfd, :kickstarter_type), subscriber, subscriber.seven_day_kickstarter_subscribed, subscriber.seven_day_kickstarter_count)
        email_scheduler_logic(Application.get_env(:nfd, :meditation_primer_type), subscriber, subscriber.ten_day_meditation_subscribed, subscriber.ten_day_meditation_count)
        email_scheduler_logic(Application.get_env(:nfd, :awareness_challenge_type), subscriber, subscriber.twenty_eight_day_awareness_subscribed, subscriber.twenty_eight_day_awareness_count)
      end)
  end

  def email_scheduler_logic(type, subscriber, is_subscribed, day_count) do
    if (is_subscribed) do
      { general_type, kickstarter_type, meditation_primer_type, awareness_challenge_type} = Nfd.Util.Email.generate_course_types()
      unsubscribe_url = Nfd.Util.Email.course_type_to_matrix(type) |> Nfd.Util.Email.generate_unsubscribe_url(subscriber.subscriber_email)
      
      IO.inspect type, label: "email_scheduler_logic"

      { template, subject } =
        case type do
          ^kickstarter_type -> EmailTemplates.run_seven_day_kickstarter(day_count)
          ^meditation_primer_type -> EmailTemplates.run_ten_day_primer(day_count)
          ^awareness_challenge_type -> EmailTemplates.run_twenty_eight_day_challenge(day_count)
        end

      case type do 
        ^kickstarter_type -> cast_course_email(subscriber, subject, template, unsubscribe_url) |> process("Seven Day NeverFap Deluxe Kickstarter - Day #{day_count} E-mail sent: " <> subscriber.subscriber_email)
        ^meditation_primer_type -> cast_course_email(subscriber, subject, template, unsubscribe_url) |> process("Ten Day Meditation Primer - Day #{day_count} E-mail sent: " <> subscriber.subscriber_email)
        ^awareness_challenge_type -> cast_course_email(subscriber, subject, template, unsubscribe_url) |> process("Twenty Eight Day Challenge - Day #{day_count} E-mail sent: " <> subscriber.subscriber_email)
      end
      
      case type do
        ^kickstarter_type -> update_subscription(type, subscriber, 7, day_count)
        ^meditation_primer_type -> update_subscription(type, subscriber, 10, day_count)
        ^awareness_challenge_type -> update_subscription(type, subscriber, 28, day_count)
      end
    end
  end

  def update_subscription(type, subscriber, subscription_day_limit, day_count) do
    { count_property, subscribed_property } = Nfd.Util.Email.type_to_subscriber_properties(type)
    
    case Meta.create_subscription_email(%{ day: day_count, course: type, subscription_email: subscriber.subscriber_email}) do
      {:ok, subscription_email} ->
        case day_count == subscription_day_limit do 
          true -> Account.update_subscriber(subscriber, %{ count_property => 0, subscribed_property => false })
          false -> Account.update_subscriber(subscriber, %{ count_property => Map.fetch!(subscriber, count_property) + 1 })
        end
      {:error, error_changeset} ->
        EmailLogs.error_email_log("#{subscriber.subscriber_email} - Failed to create Meta.SubscriptionEmail - :update_subscription")
    end
  end

  def cast_course_email(subscriber, subject, template, unsubscribe_url) do
    %Swoosh.Email{}
      |> to(subscriber.subscriber_email)
      |> from({"NeverFap Deluxe", "admin@neverfapdeluxe.com"})
      |> subject(subject)
      |> render_body(template, %{unsubscribe_url: unsubscribe_url})
  end

  def cast_confirmation_url(subscriber_email, url, unsubscribe_url, course_name, subject, template) do
    EmailLogs.new_subscriber_email_log(subscriber_email, course_name)

    %Swoosh.Email{}
      |> to(subscriber_email)
      |> from({"NeverFap Deluxe", "admin@neverfapdeluxe.com"})
      |> subject(subject)
      |> render_body(template, %{url: url, unsubscribe_url: unsubscribe_url, course_name: course_name})
  end

  def process(email, message) do
    Nfd.SwooshMailer.deliver(email)
    Logger.debug(message)
  end
end
