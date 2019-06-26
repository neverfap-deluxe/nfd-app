defmodule Nfd.Emails do
  use Swoosh.Mailer, otp_app: :nfd
  use Phoenix.Swoosh,
    view: NfdWeb.SubscriptionTemplateView,
    layout: {NfdWeb.LayoutView, :email}

  import Swoosh.Email
  require Logger

  alias Nfd.Account
  alias Nfd.Account.Subscriber

  alias Nfd.Meta

  alias Nfd.EmailTemplates
  alias Nfd.EmailLogs

  def send_day_0_email(subscriber, main_matrix) do
    { general_type, kickstarter_type, meditation_primer_type, awareness_challenge_type, awareness_seven_week_vol_1_type, awareness_seven_week_vol_2_type, awareness_seven_week_vol_3_type, awareness_seven_week_vol_4_type } = Nfd.Util.Email.generate_course_types()
    type = Nfd.Util.Email.main_matrix_to_type(main_matrix)

    case type do
      ^general_type -> nil
      ^kickstarter_type -> email_scheduler_logic(kickstarter_type, subscriber, subscriber.seven_day_kickstarter_subscribed, 0)
      ^meditation_primer_type -> email_scheduler_logic(meditation_primer_type, subscriber, subscriber.ten_day_meditation_subscribed, 0)
      ^awareness_challenge_type -> email_scheduler_logic(awareness_challenge_type, subscriber, subscriber.twenty_eight_day_awareness_subscribed, 0)
      ^awareness_seven_week_vol_1_type -> email_scheduler_logic(awareness_seven_week_vol_1_type, subscriber, subscriber.awareness_seven_week_vol_1_subscribed, 0)
      ^awareness_seven_week_vol_2_type -> email_scheduler_logic(awareness_seven_week_vol_2_type, subscriber, subscriber.awareness_seven_week_vol_2_subscribed, 0)
      ^awareness_seven_week_vol_3_type -> email_scheduler_logic(awareness_seven_week_vol_3_type, subscriber, subscriber.awareness_seven_week_vol_3_subscribed, 0)
      ^awareness_seven_week_vol_4_type -> email_scheduler_logic(awareness_seven_week_vol_4_type, subscriber, subscriber.awareness_seven_week_vol_4_subscribed, 0)
    end
  end

  # NOTE: We don't need to worry about co-ordinating Day 0, because it will just be a general information email :)
  def email_scheduler do
    Account.list_subscribers_campaign()
      |> Enum.each(fn(subscriber) ->
        email_scheduler_logic(Application.get_env(:nfd, :kickstarter_type), subscriber, subscriber.seven_day_kickstarter_subscribed, subscriber.seven_day_kickstarter_count)
        email_scheduler_logic(Application.get_env(:nfd, :meditation_primer_type), subscriber, subscriber.ten_day_meditation_subscribed, subscriber.ten_day_meditation_count)
        email_scheduler_logic(Application.get_env(:nfd, :awareness_challenge_type), subscriber, subscriber.twenty_eight_day_awareness_subscribed, subscriber.twenty_eight_day_awareness_count)
        email_scheduler_logic(Application.get_env(:nfd, :awareness_week_vol_1_type), subscriber, subscriber.awareness_seven_week_vol_1_subscribed, subscriber.awareness_seven_week_vol_1_count)
        email_scheduler_logic(Application.get_env(:nfd, :awareness_week_vol_2_type), subscriber, subscriber.awareness_seven_week_vol_2_subscribed, subscriber.awareness_seven_week_vol_2_count)
        email_scheduler_logic(Application.get_env(:nfd, :awareness_week_vol_3_type), subscriber, subscriber.awareness_seven_week_vol_3_subscribed, subscriber.awareness_seven_week_vol_3_count)
        email_scheduler_logic(Application.get_env(:nfd, :awareness_week_vol_4_type), subscriber, subscriber.awareness_seven_week_vol_4_subscribed, subscriber.awareness_seven_week_vol_4_count)
      end)
  end

  def email_scheduler_logic(type, subscriber, is_subscribed, day_count) do
    if is_subscribed do
      { _general_type, kickstarter_type, meditation_primer_type, awareness_challenge_type, awareness_seven_week_vol_1_type, awareness_seven_week_vol_2_type, awareness_seven_week_vol_3_type, awareness_seven_week_vol_4_type } = Nfd.Util.Email.generate_course_types()
      unsubscribe_url = Nfd.Util.Email.course_type_to_matrix(type) |> Nfd.Util.Email.generate_unsubscribe_url(subscriber.subscriber_email)

      has_access_to_subscription =
        case type do
          ^kickstarter_type -> true
          ^meditation_primer_type -> Subscriber.check_if_subscriber_has_paid(subscriber, Nfd.Util.Email.type_to_collection_slug(meditation_primer_type))
          ^awareness_challenge_type -> Subscriber.check_if_subscriber_has_paid(subscriber, Nfd.Util.Email.type_to_collection_slug(awareness_challenge_type))
          ^awareness_seven_week_vol_1_type -> Subscriber.check_if_subscriber_has_paid(subscriber, Nfd.Util.Email.type_to_collection_slug(awareness_seven_week_vol_1_type))
          ^awareness_seven_week_vol_2_type -> Subscriber.check_if_subscriber_has_paid(subscriber, Nfd.Util.Email.type_to_collection_slug(awareness_seven_week_vol_2_type))
          ^awareness_seven_week_vol_3_type -> Subscriber.check_if_subscriber_has_paid(subscriber, Nfd.Util.Email.type_to_collection_slug(awareness_seven_week_vol_3_type))
          ^awareness_seven_week_vol_4_type -> Subscriber.check_if_subscriber_has_paid(subscriber, Nfd.Util.Email.type_to_collection_slug(awareness_seven_week_vol_4_type))
        end

      if has_access_to_subscription do
        { template, subject } =
          case type do
            ^kickstarter_type -> EmailTemplates.run_seven_day_kickstarter(day_count)
            ^meditation_primer_type -> EmailTemplates.run_ten_day_primer(day_count)
            ^awareness_challenge_type -> EmailTemplates.run_twenty_eight_day_challenge(day_count)
            ^awareness_seven_week_vol_1_type -> EmailTemplates.run_seven_week_awareness_challenge_vol_1(day_count)
            ^awareness_seven_week_vol_2_type -> EmailTemplates.run_seven_week_awareness_challenge_vol_2(day_count)
            ^awareness_seven_week_vol_3_type -> EmailTemplates.run_seven_week_awareness_challenge_vol_3(day_count)
            ^awareness_seven_week_vol_4_type -> EmailTemplates.run_seven_week_awareness_challenge_vol_4(day_count)
          end

        case type do
          ^kickstarter_type -> cast_course_email(subscriber, subject, template, unsubscribe_url) |> process("Seven Day NeverFap Deluxe Kickstarter - Day #{day_count} E-mail sent: " <> subscriber.subscriber_email)
          ^meditation_primer_type -> cast_course_email(subscriber, subject, template, unsubscribe_url) |> process("Ten Day Meditation Primer - Day #{day_count} E-mail sent: " <> subscriber.subscriber_email)
          ^awareness_challenge_type -> cast_course_email(subscriber, subject, template, unsubscribe_url) |> process("Twenty Eight Day Challenge - Day #{day_count} E-mail sent: " <> subscriber.subscriber_email)
          ^awareness_seven_week_vol_1_type -> cast_course_email(subscriber, subject, template, unsubscribe_url) |> process("Seven Week Awareness Challenge Vol 1. - Day #{day_count} E-mail sent: " <> subscriber.subscriber_email)
          ^awareness_seven_week_vol_2_type -> cast_course_email(subscriber, subject, template, unsubscribe_url) |> process("Seven Week Awareness Challenge Vol 2. - Day #{day_count} E-mail sent: " <> subscriber.subscriber_email)
          ^awareness_seven_week_vol_3_type -> cast_course_email(subscriber, subject, template, unsubscribe_url) |> process("Seven Week Awareness Challenge Vol 3. - Day #{day_count} E-mail sent: " <> subscriber.subscriber_email)
          ^awareness_seven_week_vol_4_type -> cast_course_email(subscriber, subject, template, unsubscribe_url) |> process("Seven Week Awareness Challenge Vol 4. - Day #{day_count} E-mail sent: " <> subscriber.subscriber_email)
        end

        case type do
          ^kickstarter_type -> update_subscription(type, subscriber, 7, day_count)
          ^meditation_primer_type -> update_subscription(type, subscriber, 10, day_count)
          ^awareness_challenge_type -> update_subscription(type, subscriber, 28, day_count)
          ^awareness_seven_week_vol_1_type -> update_subscription(type, subscriber, 7, day_count)
          ^awareness_seven_week_vol_2_type -> update_subscription(type, subscriber, 7, day_count)
          ^awareness_seven_week_vol_3_type -> update_subscription(type, subscriber, 7, day_count)
          ^awareness_seven_week_vol_4_type -> update_subscription(type, subscriber, 7, day_count)
        end
      end
    end
  end

  def update_subscription(type, subscriber, subscription_day_limit, day_count) do
    { count_property, up_to_count_property, active_type_property, subscribed_property } = Nfd.Util.Email.type_to_subscriber_properties(type)

    case Meta.create_subscription_email(%{ day: day_count, course: type, subscription_email: subscriber.subscriber_email}) do
      {:ok, _subscription_email} ->

        # TODO: Test this.
        active_value = Atom.to_string(subscribed_property)
        count = Map.fetch!(subscriber, count_property) + 1
        up_to_count_original = Map.fetch!(subscriber, up_to_count_property)
        up_to_count = if up_to_count_original == subscription_day_limit, do: up_to_count_original, else: up_to_count_original + 1

        case day_count == subscription_day_limit do
          true -> Account.update_subscriber(subscriber, %{ up_to_count_property => up_to_count, active_type_property => active_value, count_property => 0, subscribed_property => false })
          false -> Account.update_subscriber(subscriber, %{ up_to_count_property => up_to_count, active_type_property => active_value, count_property => count })
        end
      {:error, _error_changeset} ->
        EmailLogs.error_email_log("#{subscriber.subscriber_email} - Failed to create Meta.SubscriptionEmail - :update_subscription")
    end
  end

  def cast_comment_made_email(email, message, referer) do
    %Swoosh.Email{}
      |> to(email)
      |> from({"NeverFap Deluxe", "admin@neverfapdeluxe.com"})
      |> subject("You made a comment on #{referer}!")
      |> render_body("template_email_comment_made.html", %{message: message, referer: referer})
  end

  def cast_comment_reply_email(email, name, message, referer) do
    %Swoosh.Email{}
      |> to(email)
      |> from({"NeverFap Deluxe", "admin@neverfapdeluxe.com"})
      |> subject("#{name} relpied to your comment on #{referer}!")
      |> render_body("template_email_comment_reply.html", %{name: name, message: message, referer: referer})
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
