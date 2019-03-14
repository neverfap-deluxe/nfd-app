defmodule NfdWeb.EmailMatrixTransform do
  use Swoosh.Mailer, otp_app: :nfd
  use Phoenix.Swoosh,
    view: NfdWeb.SubscriptionTemplateView,
    layout: {NfdWeb.LayoutView, :email}

  import Swoosh.Email
  require Logger

  alias Nfd.Account

  def subscription_confirmation_url_from_matrix(email, multiple_matrix, main_matrix) do
    case String.split(main_matrix, "h") do
      ["0", _] -> "#{NfdWeb.Endpoint.url()}/subscription_success?email=#{email}&multiple_matrix=#{multiple_matrix}&main_matrix=#{main_matrix}"
      ["1", _] -> "#{NfdWeb.Endpoint.url()}/subscription_success?email=#{email}&multiple_matrix=#{multiple_matrix}&main_matrix=#{main_matrix}"
      # ["2", _] -> "10 Day Meditation Primer"
      # ["3", _] -> "28 Day Awareness Challenge"
      # ["4", _] -> "3 Day Awareness Primer"
      # ["5", _] -> "3 Day Calmness Primer"
      # ["6", _] -> "3 Day Meditation Primer" 
    end
  end

  def course_name_from_matrix(main_matrix) do
    case String.split(main_matrix, "h") do
      ["0", _] -> "General Newsletter"
      ["1", _] -> "7 Day NeverFap Deluxe Kickstarter"
      # ["2", _] -> "10 Day Meditation Primer"
      # ["3", _] -> "28 Day Awareness Challenge"
      # ["4", _] -> "3 Day Awareness Primer"
      # ["5", _] -> "3 Day Calmness Primer"
      # ["6", _] -> "3 Day Meditation Primer" 
    end
  end

  def check_if_subscriber_is_already_subscribed(subscriber, main_matrix) do
    case String.split(main_matrix, "h") do
      ["0", _] -> subscriber.subscribed == true
      ["1", _] -> subscriber.seven_day_kickstarter_subscribed == true
      # ["2", _] -> "10 Day Meditation Primer"
      # ["3", _] -> "28 Day Awareness Challenge"
      # ["4", _] -> "3 Day Awareness Primer"
      # ["5", _] -> "3 Day Calmness Primer"
      # ["6", _] -> "3 Day Meditation Primer" 
    end
  end

  def validate_multiple_matrix(matrix) do
    Enum.map(String.split(matrix, "-"), fn(multiple_matrix) ->
      case String.split(multiple_matrix, "h") do
        ["0", pos] when pos in ["0", "1", "2"] -> true
        ["1", pos] when pos in ["0", "1", "2"] -> true
        # ["2", pos] when pos in ["0", "1", "2"] -> true
        # ["3", pos] when pos in ["0", "1", "2"] -> true
        # ["4", pos] when pos in ["0", "1", "2"] -> true
        # ["5", pos] when pos in ["0", "1", "2"] -> true
        # ["6", pos] when pos in ["0", "1", "2"] -> true
        [_, _] -> nil
      end
    end)
  end

  def update_subscription(subscriber, multiple_matrix) do 
    # Value: 0 - general, 1 kickstarter, 2 meditation, 3 awareness, 4 awareness, 5 calmness, 6 meditation 
    # Position: 0 - do nothing, 1 subscribe, 2 unsubscribe 
    # "0h1-1h1" #value 0, pos 1; value 1, pos 1;
    
    Enum.map(String.split(multiple_matrix, "-"), fn(main_matrix) ->
      # ["0", "1"]
      case String.split(main_matrix, "h") do
        ["0", pos] -> NfdWeb.GeneralScheduler.subscription_action(subscriber, pos)
        ["1", pos] -> NfdWeb.SevenDayKickstarterScheduler.subscription_action(subscriber, pos)
        # ["2", pos] -> NfdWeb.TenDayMeditationScheduler.subscription_action(subscriber, pos)
        # ["3", pos] -> NfdWeb.TwentyEightDayAwarenessScheduler.subscription_action(subscriber, pos)
        # ["4", pos] -> NfdWeb.ThreeDayAwarenessScheduler.subscription_action(subscriber, pos)
        # ["5", pos] -> NfdWeb.ThreeDayCalmnessScheduler.subscription_action(subscriber, pos)
        # ["6", pos] -> NfdWeb.ThreeDayMeditationScheduler.subscription_action(subscriber, pos)
      end
    end)
  end

  def unsubscribe_subscriber(subscriber, main_matrix) do
    case String.split(main_matrix, "h") do
      ["0", pos] -> NfdWeb.GeneralScheduler.unsubscribe_action(subscriber)
      ["1", pos] -> NfdWeb.SevenDayKickstarterScheduler.unsubscribe_action(subscriber)
      # ["2", pos] -> NfdWeb.TenDayMeditationScheduler.subscription_action(subscriber, pos)
      # ["3", pos] -> NfdWeb.TwentyEightDayAwarenessScheduler.subscription_action(subscriber, pos)
      # ["4", pos] -> NfdWeb.ThreeDayAwarenessScheduler.subscription_action(subscriber, pos)
      # ["5", pos] -> NfdWeb.ThreeDayCalmnessScheduler.subscription_action(subscriber, pos)
      # ["6", pos] -> NfdWeb.ThreeDayMeditationScheduler.subscription_action(subscriber, pos)
    end
  end

end
