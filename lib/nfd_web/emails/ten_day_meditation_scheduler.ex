defmodule NfdWeb.TenDayMeditationScheduler do
  alias Nfd.Account

  def subscription_action(subscriber, pos) do
    case pos do 
      "0" -> nil
      "1" -> Account.update_subscriber(subscriber, %{ ten_day_meditation_subscribed: true })
      "2" -> Account.update_subscriber(subscriber, %{ ten_day_meditation_subscribed: false })
    end
  end

  # TODO Will still need titles for these
  def run(count) do
    case count do
      0 -> { "template_ten_day_meditation_0.html", "" }
      1 -> { "template_ten_day_meditation_1.html", "" }
      2 -> { "template_ten_day_meditation_2.html", "" }
      3 -> { "template_ten_day_meditation_3.html", "" }
      4 -> { "template_ten_day_meditation_4.html", "" }
      5 -> { "template_ten_day_meditation_5.html", "" }
      6 -> { "template_ten_day_meditation_6.html", "" }
      7 -> { "template_ten_day_meditation_7.html", "" }
      8 -> { "template_ten_day_meditation_8.html", "" }
      9 -> { "template_ten_day_meditation_9.html", "" }
      10 -> { "template_ten_day_meditation_10.html", "" }
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
