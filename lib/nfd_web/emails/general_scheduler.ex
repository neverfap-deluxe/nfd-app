defmodule NfdWeb.GeneralScheduler do
  alias Nfd.Account

  def subscription_action(subscriber, pos) do
    case pos do 
      "0" -> nil
      "1" -> Account.update_subscriber(subscriber, %{ subscribed: true })
      "2" -> Account.update_subscriber(subscriber, %{ subscribed: false })
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