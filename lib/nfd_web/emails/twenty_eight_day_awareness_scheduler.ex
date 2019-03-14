defmodule NfdWeb.TwentyEightDayAwarenessScheduler do
  alias Nfd.Account

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
      11 -> { "", "" }
      12 -> { "", "" }
      13 -> { "", "" }
      14 -> { "", "" }
      15 -> { "", "" }
      16 -> { "", "" }
      17 -> { "", "" }
      18 -> { "", "" }
      19 -> { "", "" }
      20 -> { "", "" }
      21 -> { "", "" }
      22 -> { "", "" }
      23 -> { "", "" }
      24 -> { "", "" }
      25 -> { "", "" }
      26 -> { "", "" }
      27 -> { "", "" }
      28 -> { "", "" }
    end
  end

  def update(subscriber, day_count) do 
    if (day_count == 28) do
      Account.update_subscriber(subscriber, %{ twenty_eight_day_awareness_subscribed: false, twenty_eight_day_awareness_count: 0 })
    else
      incremented_counter = subscriber.twenty_eight_day_awareness_count + 1
      Account.update_subscriber(subscriber, %{ twenty_eight_day_awareness_count: incremented_counter })
    end
  end

  def subscription_action(subscriber, pos) do
    case pos do 
      "0" -> nil
      "1" -> Account.update_subscriber(subscriber, %{ twenty_eight_day_awareness_subscribed: true })
      "2" -> Account.update_subscriber(subscriber, %{ twenty_eight_day_awareness_subscribed: false })
    end
  end

end
