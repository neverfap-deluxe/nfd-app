defmodule NfdWeb.EmailTemplates do

  def run_seven_day_kickstarter(count) do
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

  # TODO Will still need titles for these
  def run_ten_day_primer(count) do
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
  
  # TODO Will still need titles for these
  def run_twenty_eight_day_challenge(count) do 
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

end