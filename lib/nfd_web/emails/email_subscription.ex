defmodule NfdWeb.EmailSubscription do
  use Swoosh.Mailer, otp_app: :nfd
  use Phoenix.Swoosh, 
    view: NfdWeb.SubscriptionView, 
    layout: {NfdWeb.LayoutView, :email}

  import Swoosh.Email
  require Logger

  alias Nfd.Account

  def send_email_subscription(subscriber, matrix_element) do
    cast_subscriber(
      subscriber,
      "Confirm your subscription", 
      "template_email_subscription_confirmation.html"
    ) |> process("Confirm your subscription E-mail sent: " <> subscriber.email)
  end

  def course_name_from_matrix(matrix_element) do
    case String.split(matrix_element, "+") do
      [0, _] -> "General Newsletter"
      [1, _] -> "7 Day NeverFap Deluxe Kickstarter"
      [2, _] -> "10 Day Meditation Primer"
      [3, _] -> "28 Day Awareness Challenge"
      [4, _] -> "3 Day Awareness Primer"
      [5, _] -> "3 Day Calmness Primer"
      [6, _] -> "3 Day Meditation Primer" 
    end
  end

  def validate_matrix_element(matrix_element) do 
    case String.split(matrix_element, "+") do
      [0, pos] when pos in [0, 1, 2] -> true
      [1, pos] when pos in [0, 1, 2] -> true
      [2, pos] when pos in [0, 1, 2] -> true
      [3, pos] when pos in [0, 1, 2] -> true
      [4, pos] when pos in [0, 1, 2] -> true
      [5, pos] when pos in [0, 1, 2] -> true
      [6, pos] when pos in [0, 1, 2] -> true
      [_, _] -> nil
    end
  end

  def update_subscription(subscriber, matrix_element) do 
    # Value: 0 - do nothing, 1 subscribe, 2 unsubscribe 
    # Position: 0 - general, 1 kickstarter, 2 meditation, 3 awareness, 4 awareness, 5 calmness, 6 meditation 
    # "0+1-1+1" #value 0, pos 1; value 1, pos 1;
    
    # Enum.map(String.split(matrix_element, "-"), fn(campaign) ->
      # ["0", "1"]
      case String.split(matrix_element, "+") do
        [0, pos] -> NfdWeb.GeneralScheduler.subscription_action(subscriber, pos)
        [1, pos] -> NfdWeb.SevenDayKickstarterScheduler.subscription_action(subscriber, pos)
        [2, pos] -> NfdWeb.TenDayMeditationScheduler.subscription_action(subscriber, pos)
        [3, pos] -> NfdWeb.TwentyEightDayAwarenessScheduler.subscription_action(subscriber, pos)
        [4, pos] -> NfdWeb.ThreeDayAwarenessScheduler.subscription_action(subscriber, pos)
        [5, pos] -> NfdWeb.ThreeDayCalmnessScheduler.subscription_action(subscriber, pos)
        [6, pos] -> NfdWeb.ThreeDayMeditationScheduler.subscription_action(subscriber, pos)
      end
    # end)
  end

  def cast_subscriber(subscriber, subject, template) do
    # TODO: Put in variables into template
    %Swoosh.Email{}
      |> to(subscriber.subscriber_email)
      |> from({"NeverFap Deluxe", "neverfapdeluxe@gmail.com"})
      |> subject(subject)
      |> render_body(template, %{})
  end

  def process(email, message) do
    Nfd.SwooshMailer.deliver(email)

    Logger.debug(message)
  end
end
