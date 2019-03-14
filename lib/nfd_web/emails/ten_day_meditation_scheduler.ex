defmodule NfdWeb.TenDayMeditationScheduler do
  alias Nfd.Account

  defp subscription_action(subscriber, pos) do
    case pos do 
      "0" -> nil
      "1" -> Account.update_subscriber(subscriber, %{ ten_day_meditation_subscribed: true })
      "2" -> Account.update_subscriber(subscriber, %{ ten_day_meditation_subscribed: false })
    end
  end

  def run(count) do
    case count do
      0 -> { "", "" }
      1 -> { "", "" }
      2 -> { "", "" }
      3 -> { "", "" }
      4 -> { "", "" }
      5 -> { "", "" }
      6 -> { "", "" }
      7 -> { "", "" }
      8 -> { "", "" }
      9 -> { "", "" }
      10 -> { "", "" }
    end
  end

  def update(subscriber, day_count) do 
    if (day_count == 10) do
      Account.update_subscriber(subscriber, %{ ten_day_meditation_subscribed: false, ten_day_meditation_count: 0 })
    else
      incremented_counter = subscriber.ten_day_meditation_count + 1
      Account.update_subscriber(subscriber, %{ ten_day_meditation_count: incremented_counter })
    end
  end
end
