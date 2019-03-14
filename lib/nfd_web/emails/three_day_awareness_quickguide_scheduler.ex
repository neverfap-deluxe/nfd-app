defmodule NfdWeb.ThreeDayAwarenessScheduler do
  alias Nfd.Account

  def run(count) do
    case count do
      0 -> { "", "" }
      1 -> { "", "" }
      2 -> { "", "" }
      3 -> { "", "" }
    end
  end

  def update(subscriber, day_count) do 
    if (day_count == 3) do
      Account.update_subscriber(subscriber, %{ three_day_awareness_subscribed: false, three_day_awareness_count: 0 })
    else
      incremented_counter = subscriber.three_day_awareness_count + 1
      Account.update_subscriber(subscriber, %{ three_day_awareness_count: incremented_counter })
    end
  end
end
