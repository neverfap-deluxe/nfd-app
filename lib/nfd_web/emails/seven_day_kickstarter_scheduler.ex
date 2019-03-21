defmodule NfdWeb.SevenDayKickstarterScheduler do
  alias Nfd.Account
  alias Nfd.Meta

  alias Nfd.EmailLogs

  def subscription_action(subscriber, pos) do
    IO.inspect "sub #{pos}"

    case pos do 
      "0" -> nil
      "1" -> 
        case Account.update_subscriber(subscriber, %{ seven_day_kickstarter_subscribed: true }) do
          {:ok, updated_subscriber} -> updated_subscriber
          {:error, changeset} -> 
            EmailLogs.error_email_log("#{subscriber.subscriber_email} - Would not subscribe subscriber - subscription_action - seven_day_kickstarter_scheduler.")        
            false
        end
      "2" -> 
        case Account.update_subscriber(subscriber, %{ seven_day_kickstarter_subscribed: false }) do
          {:ok, updated_subscriber} -> updated_subscriber
          {:error, changeset} -> 
            EmailLogs.error_email_log("#{subscriber.subscriber_email} - Would not unsubscribe subscriber - subscription_action - seven_day_kickstarter_scheduler.")        
            false
        end
    end
  end

  def unsubscribe_action(subscriber) do
    # TODO: Implement error handling for this. 
    Account.update_subscriber(subscriber, %{ seven_day_kickstarter_subscribed: false })
  end

  def run(count) do
    case count do
      0 -> { "template_seven_day_kickstarter_0.html", "7 Day NeverFap Deluxe Kickstarter - The Beginning - Day 0" }
      1 -> { "template_seven_day_kickstarter_0.html", "7 Day NeverFap Deluxe Kickstarter - The Meditation - Day 1" }
      2 -> { "template_seven_day_kickstarter_1.html", "7 Day NeverFap Deluxe Kickstarter - The Awareness - Day 2" }
      3 -> { "template_seven_day_kickstarter_2.html", "7 Day NeverFap Deluxe Kickstarter - The Calmness - Day 3" }
      4 -> { "template_seven_day_kickstarter_3.html", "7 Day NeverFap Deluxe Kickstarter - The Trust - Day 4" }
      5 -> { "template_seven_day_kickstarter_4.html", "7 Day NeverFap Deluxe Kickstarter - The Relapse - Day 5" }
      6 -> { "template_seven_day_kickstarter_5.html", "7 Day NeverFap Deluxe Kickstarter - The Ambition - Day 6" }
      7 -> { "template_seven_day_kickstarter_6.html", "7 Day NeverFap Deluxe Kickstarter - The Consistency - Day 7" }
    end
  end

  def update(subscriber, day_count) do
    case Meta.create_subscription_email(%{ day: day_count, course: "sevendayneverfapdeluxekickstarter", subscription_email: subscriber.subscriber_email}) do
      {:ok, subscription_email} ->
        if (day_count == 7) do
          Account.update_subscriber(subscriber, %{ seven_day_kickstarter_subscribed: false, seven_day_kickstarter_count: 0 })
        else
          incremented_counter = subscriber.seven_day_kickstarter_count + 1
          Account.update_subscriber(subscriber, %{ seven_day_kickstarter_count: incremented_counter })
        end
      {:error, error_changeset} ->
        EmailLogs.error_email_log("#{subscriber.subscriber_email} - Failed to create Meta.SubscriptionEmail - seven_day_kickstarter_scheduler")
    end

  end
end
