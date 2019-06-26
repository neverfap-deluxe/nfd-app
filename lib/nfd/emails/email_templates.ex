defmodule Nfd.EmailTemplates do

  def run_seven_day_kickstarter(count) do
    case count do
      0 -> { "template_seven_day_kickstarter_0.html", "7 Day NeverFap Deluxe Kickstarter - #{Application.get_env(:nfd, :kickstarter_day_0_title)} - Day 0" }
      1 -> { "template_seven_day_kickstarter_1.html", "7 Day NeverFap Deluxe Kickstarter - #{Application.get_env(:nfd, :kickstarter_day_1_title)} - Day 1" }
      2 -> { "template_seven_day_kickstarter_2.html", "7 Day NeverFap Deluxe Kickstarter - #{Application.get_env(:nfd, :kickstarter_day_2_title)} - Day 2" }
      3 -> { "template_seven_day_kickstarter_3.html", "7 Day NeverFap Deluxe Kickstarter - #{Application.get_env(:nfd, :kickstarter_day_3_title)} - Day 3" }
      4 -> { "template_seven_day_kickstarter_4.html", "7 Day NeverFap Deluxe Kickstarter - #{Application.get_env(:nfd, :kickstarter_day_4_title)} - Day 4" }
      5 -> { "template_seven_day_kickstarter_5.html", "7 Day NeverFap Deluxe Kickstarter - #{Application.get_env(:nfd, :kickstarter_day_5_title)} - Day 5" }
      6 -> { "template_seven_day_kickstarter_6.html", "7 Day NeverFap Deluxe Kickstarter - #{Application.get_env(:nfd, :kickstarter_day_6_title)} - Day 6" }
      7 -> { "template_seven_day_kickstarter_7.html", "7 Day NeverFap Deluxe Kickstarter - #{Application.get_env(:nfd, :kickstarter_day_7_title)} - Day 7" }
      _ -> { false, false }
    end
  end

  def run_ten_day_primer(count) do
    case count do
      0 -> { "template_ten_day_meditation_0.html", "10 Day Meditation Primer - #{Application.get_env(:nfd, :primer_day_0_title)} - Day 0" }
      1 -> { "template_ten_day_meditation_1.html", "10 Day Meditation Primer - #{Application.get_env(:nfd, :primer_day_1_title)} - Day 1" }
      2 -> { "template_ten_day_meditation_2.html", "10 Day Meditation Primer - #{Application.get_env(:nfd, :primer_day_2_title)} - Day 2" }
      3 -> { "template_ten_day_meditation_3.html", "10 Day Meditation Primer - #{Application.get_env(:nfd, :primer_day_3_title)} - Day 3" }
      4 -> { "template_ten_day_meditation_4.html", "10 Day Meditation Primer - #{Application.get_env(:nfd, :primer_day_4_title)} - Day 4" }
      5 -> { "template_ten_day_meditation_5.html", "10 Day Meditation Primer - #{Application.get_env(:nfd, :primer_day_5_title)} - Day 5" }
      6 -> { "template_ten_day_meditation_6.html", "10 Day Meditation Primer - #{Application.get_env(:nfd, :primer_day_6_title)} - Day 6" }
      7 -> { "template_ten_day_meditation_7.html", "10 Day Meditation Primer - #{Application.get_env(:nfd, :primer_day_7_title)} - Day 7" }
      8 -> { "template_ten_day_meditation_8.html", "10 Day Meditation Primer - #{Application.get_env(:nfd, :primer_day_8_title)} - Day 8" }
      9 -> { "template_ten_day_meditation_9.html", "10 Day Meditation Primer - #{Application.get_env(:nfd, :primer_day_9_title)} - Day 9" }
      10 -> { "template_ten_day_meditation_10.html", "10 Day Meditation Primer - #{Application.get_env(:nfd, :primer_day_10_title)} - Day 10" }
      11 -> { "template_ten_day_meditation_11.html", "10 Day Meditation Primer - #{Application.get_env(:nfd, :primer_day_11_title)}" }
      _ -> { false, false }
    end
  end

  # TODO: Build in last day templates, both in files.

  def run_seven_week_awareness_challenge_vol_1(count) do
    case count do
      0 -> { "template_seven_week_awareness_vol_1_0.html", "7 Week Awareness Challenge Vol 1 - #{Application.get_env(:nfd, :seven_week_vol_1_week_0_title)} - Week 0" }
      1 -> { "template_seven_week_awareness_vol_1_1.html", "7 Week Awareness Challenge Vol 1 - #{Application.get_env(:nfd, :seven_week_vol_1_week_1_title)} - Week 1" }
      8 -> { "template_seven_week_awareness_vol_1_2.html", "7 Week Awareness Challenge Vol 1 - #{Application.get_env(:nfd, :seven_week_vol_1_week_2_title)} - Week 2" }
      15 -> { "template_seven_week_awareness_vol_1_3.html", "7 Week Awareness Challenge Vol 1 - #{Application.get_env(:nfd, :seven_week_vol_1_week_3_title)} - Week 3" }
      22 -> { "template_seven_week_awareness_vol_1_4.html", "7 Week Awareness Challenge Vol 1 - #{Application.get_env(:nfd, :seven_week_vol_1_week_4_title)} - Week 4" }
      29 -> { "template_seven_week_awareness_vol_1_5.html", "7 Week Awareness Challenge Vol 1 - #{Application.get_env(:nfd, :seven_week_vol_1_week_5_title)} - Week 5" }
      36 -> { "template_seven_week_awareness_vol_1_6.html", "7 Week Awareness Challenge Vol 1 - #{Application.get_env(:nfd, :seven_week_vol_1_week_6_title)} - Week 6" }
      43 -> { "template_seven_week_awareness_vol_1_7.html", "7 Week Awareness Challenge Vol 1 - #{Application.get_env(:nfd, :seven_week_vol_1_week_7_title)} - Week 7" }
      50 -> { "template_seven_week_awareness_vol_1_8.html", "7 Week Awareness Challenge Vol 1 - #{Application.get_env(:nfd, :seven_week_vol_1_week_8_title)}" }
      _ -> { false, false }
    end
  end

  def run_seven_week_awareness_challenge_vol_2(count) do
    case count do
      0 -> { "template_seven_week_awareness_vol_2_0.html", "7 Week Awareness Challenge Vol 2 - #{Application.get_env(:nfd, :seven_week_vol_2_week_0_title)} - Week 0" }
      1 -> { "template_seven_week_awareness_vol_2_1.html", "7 Week Awareness Challenge Vol 2 - #{Application.get_env(:nfd, :seven_week_vol_2_week_1_title)} - Week 1" }
      8 -> { "template_seven_week_awareness_vol_2_2.html", "7 Week Awareness Challenge Vol 2 - #{Application.get_env(:nfd, :seven_week_vol_2_week_2_title)} - Week 2" }
      15 -> { "template_seven_week_awareness_vol_2_3.html", "7 Week Awareness Challenge Vol 2 - #{Application.get_env(:nfd, :seven_week_vol_2_week_3_title)} - Week 3" }
      22 -> { "template_seven_week_awareness_vol_2_4.html", "7 Week Awareness Challenge Vol 2 - #{Application.get_env(:nfd, :seven_week_vol_2_week_4_title)} - Week 4" }
      29 -> { "template_seven_week_awareness_vol_2_5.html", "7 Week Awareness Challenge Vol 2 - #{Application.get_env(:nfd, :seven_week_vol_2_week_5_title)} - Week 5" }
      36 -> { "template_seven_week_awareness_vol_2_6.html", "7 Week Awareness Challenge Vol 2 - #{Application.get_env(:nfd, :seven_week_vol_2_week_6_title)} - Week 6" }
      43 -> { "template_seven_week_awareness_vol_2_7.html", "7 Week Awareness Challenge Vol 2 - #{Application.get_env(:nfd, :seven_week_vol_2_week_7_title)} - Week 7" }
      50 -> { "template_seven_week_awareness_vol_2_8.html", "7 Week Awareness Challenge Vol 2 - #{Application.get_env(:nfd, :seven_week_vol_2_week_8_title)}" }
      _ -> { false, false }
    end
  end

  def run_seven_week_awareness_challenge_vol_3(count) do
    case count do
      0 -> { "template_seven_week_awareness_vol_3_0.html", "7 Week Awareness Challenge Vol 3 - #{Application.get_env(:nfd, :seven_week_vol_3_week_0_title)} - Week 0" }
      1 -> { "template_seven_week_awareness_vol_3_1.html", "7 Week Awareness Challenge Vol 3 - #{Application.get_env(:nfd, :seven_week_vol_3_week_1_title)} - Week 1" }
      8 -> { "template_seven_week_awareness_vol_3_2.html", "7 Week Awareness Challenge Vol 3 - #{Application.get_env(:nfd, :seven_week_vol_3_week_2_title)} - Week 2" }
      15 -> { "template_seven_week_awareness_vol_3_3.html", "7 Week Awareness Challenge Vol 3 - #{Application.get_env(:nfd, :seven_week_vol_3_week_3_title)} - Week 3" }
      22 -> { "template_seven_week_awareness_vol_3_4.html", "7 Week Awareness Challenge Vol 3 - #{Application.get_env(:nfd, :seven_week_vol_3_week_4_title)} - Week 4" }
      29 -> { "template_seven_week_awareness_vol_3_5.html", "7 Week Awareness Challenge Vol 3 - #{Application.get_env(:nfd, :seven_week_vol_3_week_5_title)} - Week 5" }
      36 -> { "template_seven_week_awareness_vol_3_6.html", "7 Week Awareness Challenge Vol 3 - #{Application.get_env(:nfd, :seven_week_vol_3_week_6_title)} - Week 6" }
      43 -> { "template_seven_week_awareness_vol_3_7.html", "7 Week Awareness Challenge Vol 3 - #{Application.get_env(:nfd, :seven_week_vol_3_week_7_title)} - Week 7" }
      50 -> { "template_seven_week_awareness_vol_3_8.html", "7 Week Awareness Challenge Vol 3 - #{Application.get_env(:nfd, :seven_week_vol_3_week_8_title)}" }
      _ -> { false, false }
    end
  end

  def run_seven_week_awareness_challenge_vol_4(count) do
    case count do
      0 -> { "template_seven_week_awareness_vol_4_0.html", "7 Week Awareness Challenge Vol 4 - #{Application.get_env(:nfd, :seven_week_vol_4_week_0_title)} - Week 0" }
      1 -> { "template_seven_week_awareness_vol_4_1.html", "7 Week Awareness Challenge Vol 4 - #{Application.get_env(:nfd, :seven_week_vol_4_week_1_title)} - Week 1" }
      8 -> { "template_seven_week_awareness_vol_4_2.html", "7 Week Awareness Challenge Vol 4 - #{Application.get_env(:nfd, :seven_week_vol_4_week_2_title)} - Week 2" }
      15 -> { "template_seven_week_awareness_vol_4_3.html", "7 Week Awareness Challenge Vol 4 - #{Application.get_env(:nfd, :seven_week_vol_4_week_3_title)} - Week 3" }
      22 -> { "template_seven_week_awareness_vol_4_4.html", "7 Week Awareness Challenge Vol 4 - #{Application.get_env(:nfd, :seven_week_vol_4_week_4_title)} - Week 4" }
      29 -> { "template_seven_week_awareness_vol_4_5.html", "7 Week Awareness Challenge Vol 4 - #{Application.get_env(:nfd, :seven_week_vol_4_week_5_title)} - Week 5" }
      36 -> { "template_seven_week_awareness_vol_4_6.html", "7 Week Awareness Challenge Vol 4 - #{Application.get_env(:nfd, :seven_week_vol_4_week_6_title)} - Week 6" }
      43 -> { "template_seven_week_awareness_vol_4_7.html", "7 Week Awareness Challenge Vol 4 - #{Application.get_env(:nfd, :seven_week_vol_4_week_7_title)} - Week 7" }
      50 -> { "template_seven_week_awareness_vol_4_8.html", "7 Week Awareness Challenge Vol 4 - #{Application.get_env(:nfd, :seven_week_vol_4_week_8_title)}" }
      _ -> { false, false }
    end
  end


  def run_twenty_eight_day_challenge(count) do
    case count do
      0 -> { "template_twenty_eight_day_awareness_0", "28 Day Awareness Challenge - #{Application.get_env(:nfd, :challenge_day_0_title)} - Day 0" }
      1 -> { "template_twenty_eight_day_awareness_1", "28 Day Awareness Challenge - #{Application.get_env(:nfd, :challenge_day_1_title)} - Day 1" }
      2 -> { "template_twenty_eight_day_awareness_2", "28 Day Awareness Challenge - #{Application.get_env(:nfd, :challenge_day_2_title)} - Day 2" }
      3 -> { "template_twenty_eight_day_awareness_3", "28 Day Awareness Challenge - #{Application.get_env(:nfd, :challenge_day_3_title)} - Day 3" }
      4 -> { "template_twenty_eight_day_awareness_4", "28 Day Awareness Challenge - #{Application.get_env(:nfd, :challenge_day_4_title)} - Day 4" }
      5 -> { "template_twenty_eight_day_awareness_5", "28 Day Awareness Challenge - #{Application.get_env(:nfd, :challenge_day_5_title)} - Day 5" }
      6 -> { "template_twenty_eight_day_awareness_6", "28 Day Awareness Challenge - #{Application.get_env(:nfd, :challenge_day_6_title)} - Day 6" }
      7 -> { "template_twenty_eight_day_awareness_7", "28 Day Awareness Challenge - #{Application.get_env(:nfd, :challenge_day_7_title)} - Day 7" }
      8 -> { "template_twenty_eight_day_awareness_8", "28 Day Awareness Challenge - #{Application.get_env(:nfd, :challenge_day_8_title)} - Day 8" }
      9 -> { "template_twenty_eight_day_awareness_9", "28 Day Awareness Challenge - #{Application.get_env(:nfd, :challenge_day_9_title)} - Day 9" }
      10 -> { "template_twenty_eight_day_awareness_10", "28 Day Awareness Challenge - #{Application.get_env(:nfd, :challenge_day_10_title)} - Day 10" }
      11 -> { "template_twenty_eight_day_awareness_11", "28 Day Awareness Challenge - #{Application.get_env(:nfd, :challenge_day_11_title)} - Day 11" }
      12 -> { "template_twenty_eight_day_awareness_12", "28 Day Awareness Challenge - #{Application.get_env(:nfd, :challenge_day_12_title)} - Day 12" }
      13 -> { "template_twenty_eight_day_awareness_13", "28 Day Awareness Challenge - #{Application.get_env(:nfd, :challenge_day_13_title)} - Day 13" }
      14 -> { "template_twenty_eight_day_awareness_14", "28 Day Awareness Challenge - #{Application.get_env(:nfd, :challenge_day_14_title)} - Day 14" }
      15 -> { "template_twenty_eight_day_awareness_15", "28 Day Awareness Challenge - #{Application.get_env(:nfd, :challenge_day_15_title)} - Day 15" }
      16 -> { "template_twenty_eight_day_awareness_16", "28 Day Awareness Challenge - #{Application.get_env(:nfd, :challenge_day_16_title)} - Day 16" }
      17 -> { "template_twenty_eight_day_awareness_17", "28 Day Awareness Challenge - #{Application.get_env(:nfd, :challenge_day_17_title)} - Day 17" }
      18 -> { "template_twenty_eight_day_awareness_18", "28 Day Awareness Challenge - #{Application.get_env(:nfd, :challenge_day_18_title)} - Day 18" }
      19 -> { "template_twenty_eight_day_awareness_19", "28 Day Awareness Challenge - #{Application.get_env(:nfd, :challenge_day_19_title)} - Day 19" }
      20 -> { "template_twenty_eight_day_awareness_20", "28 Day Awareness Challenge - #{Application.get_env(:nfd, :challenge_day_20_title)} - Day 20" }
      21 -> { "template_twenty_eight_day_awareness_21", "28 Day Awareness Challenge - #{Application.get_env(:nfd, :challenge_day_21_title)} - Day 21" }
      22 -> { "template_twenty_eight_day_awareness_22", "28 Day Awareness Challenge - #{Application.get_env(:nfd, :challenge_day_22_title)} - Day 22" }
      23 -> { "template_twenty_eight_day_awareness_23", "28 Day Awareness Challenge - #{Application.get_env(:nfd, :challenge_day_23_title)} - Day 23" }
      24 -> { "template_twenty_eight_day_awareness_24", "28 Day Awareness Challenge - #{Application.get_env(:nfd, :challenge_day_24_title)} - Day 24" }
      25 -> { "template_twenty_eight_day_awareness_25", "28 Day Awareness Challenge - #{Application.get_env(:nfd, :challenge_day_25_title)} - Day 25" }
      26 -> { "template_twenty_eight_day_awareness_26", "28 Day Awareness Challenge - #{Application.get_env(:nfd, :challenge_day_26_title)} - Day 26" }
      27 -> { "template_twenty_eight_day_awareness_27", "28 Day Awareness Challenge - #{Application.get_env(:nfd, :challenge_day_27_title)} - Day 27" }
      28 -> { "template_twenty_eight_day_awareness_28", "28 Day Awareness Challenge - #{Application.get_env(:nfd, :challenge_day_28_title)} - Day 28" }
      28 -> { "template_twenty_eight_day_awareness_29", "28 Day Awareness Challenge - #{Application.get_env(:nfd, :challenge_day_29_title)}" }
      _ -> { false, false }
    end
  end
end
