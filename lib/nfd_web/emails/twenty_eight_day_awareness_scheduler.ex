defmodule NfdWeb.TwentyEightDayAwarenessScheduler do
  alias Nfd.Account

  def run(count) do
    case count do
      0 -> { "template_twenty_eight_day_awareness_0", "" }
      1 -> { "template_twenty_eight_day_awareness_1", "" }
      2 -> { "template_twenty_eight_day_awareness_2", "" }
      3 -> { "template_twenty_eight_day_awareness_3", "" }
      4 -> { "template_twenty_eight_day_awareness_4", "" }
      5 -> { "template_twenty_eight_day_awareness_5", "" }
      6 -> { "template_twenty_eight_day_awareness_6", "" }
      7 -> { "template_twenty_eight_day_awareness_7", "" }
      8 -> { "template_twenty_eight_day_awareness_8", "" }
      9 -> { "template_twenty_eight_day_awareness_9", "" }
      10 -> { "template_twenty_eight_day_awareness_10", "" }
      11 -> { "template_twenty_eight_day_awareness_11", "" }
      12 -> { "template_twenty_eight_day_awareness_12", "" }
      13 -> { "template_twenty_eight_day_awareness_13", "" }
      14 -> { "template_twenty_eight_day_awareness_14", "" }
      15 -> { "template_twenty_eight_day_awareness_15", "" }
      16 -> { "template_twenty_eight_day_awareness_16", "" }
      17 -> { "template_twenty_eight_day_awareness_17", "" }
      18 -> { "template_twenty_eight_day_awareness_18", "" }
      19 -> { "template_twenty_eight_day_awareness_19", "" }
      20 -> { "template_twenty_eight_day_awareness_20", "" }
      21 -> { "template_twenty_eight_day_awareness_21", "" }
      22 -> { "template_twenty_eight_day_awareness_22", "" }
      23 -> { "template_twenty_eight_day_awareness_23", "" }
      24 -> { "template_twenty_eight_day_awareness_24", "" }
      25 -> { "template_twenty_eight_day_awareness_25", "" }
      26 -> { "template_twenty_eight_day_awareness_26", "" }
      27 -> { "template_twenty_eight_day_awareness_27", "" }
      28 -> { "template_twenty_eight_day_awareness_28", "" }
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
