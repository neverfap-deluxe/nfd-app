defmodule NfdWeb.GeneralScheduler do
  alias Nfd.Account

  def subscription_action(subscriber, pos) do
    IO.inspect "general #{pos}"
    case pos do 
      "0" -> nil
      "1" -> 
        case Account.update_subscriber(subscriber, %{ subscribed: true }) do
          {:ok, updated_subscriber} -> updated_subscriber
          {:error, changeset} -> 
            EmailLogs.error_email_log("#{subscriber.subscriber_email} - Would not subscribe subscriber - subscription_action - general_scheduler.")        
            false
        end
      "2" -> 
        case Account.update_subscriber(subscriber, %{ subscribed: false }) do
          {:ok, updated_subscriber} -> updated_subscriber
          {:error, changeset} -> 
            EmailLogs.error_email_log("#{subscriber.subscriber_email} - Would not unsubscribe subscriber - subscription_action - general_scheduler.")        
            false
        end
    end
  end

  def unsubscribe_action(subscriber) do
    Account.update_subscriber(subscriber, %{ subscribed: false })
  end

  # Not part of this 
  # def update(subscriber, day_count) do 
  #   if (day_count == 7) do
  #     Account.update_subscriber(subscriber, %{ seven_day_kickstarter_subscribed: false, seven_day_kickstarter_count: 0 })
  #   else
  #     incremented_counter = subscriber.seven_day_kickstarter_count + 1
  #     Account.update_subscriber(subscriber, %{ seven_day_kickstarter_count: incremented_counter })
  #   end
  # end
end
