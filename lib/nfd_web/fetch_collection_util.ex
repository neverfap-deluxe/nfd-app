defmodule NfdWeb.FetchCollectionUtil do

  alias Nfd.API.PageAPI
  alias Nfd.API.ContentAPI

  alias Nfd.Util.Email

  alias Nfd.Meta
  alias Nfd.Meta.Comment
  alias Nfd.Meta.Page

  alias Nfd.Content
  alias Nfd.Content.Collection

  alias Nfd.Account.Subscriber

  def generate_seven_week_awareness_challenge_symbol(vol) do
    case vol do
      "1" -> :seven_week_awareness_vol_1_single
      "2" -> :seven_week_awareness_vol_2_single
      "3" -> :seven_week_awareness_vol_3_single
      "4" -> :seven_week_awareness_vol_4_single
      "5" -> :seven_week_awareness_vol_5_single
      "6" -> :seven_week_awareness_vol_6_single
      _ -> nil
    end
  end

  def collection_slug_to_page_symbol(collection_slug) do
    case collection_slug do
      "seven-day-neverfap-deluxe-kickstarter" -> :seven_day_kickstarter_single
      "ten-day-meditation-primer" -> :ten_day_meditation_single
      "twenty-eight-day-awareness-challenge" -> :twenty_eight_day_awareness_single
      "seven-week-awareness-challenge-vol-1" -> :seven_week_awareness_vol_1_single
      "seven-week-awareness-challenge-vol-2" -> :seven_week_awareness_vol_2_single
      "seven-week-awareness-challenge-vol-3" -> :seven_week_awareness_vol_3_single
      "seven-week-awareness-challenge-vol-4" -> :seven_week_awareness_vol_4_single
      _ -> ""
    end
  end

  def page_symbol_to_collection_slug(page_symbol) do
    case page_symbol do
      :seven_day_kickstarter_single -> "seven-day-neverfap-deluxe-kickstarter"
      :ten_day_meditation_single -> "ten-day-meditation-primer"
      :twenty_eight_day_awareness_single -> "twenty-eight-day-awareness-challenge"
      :seven_week_awareness_vol_1_single -> "seven-week-awareness-challenge-vol-1"
      :seven_week_awareness_vol_2_single -> "seven-week-awareness-challenge-vol-2"
      :seven_week_awareness_vol_3_single -> "seven-week-awareness-challenge-vol-3"
      :seven_week_awareness_vol_4_single -> "seven-week-awareness-challenge-vol-4"
      _ -> ""
    end
  end

  def course_slug_to_up_to_count(course_slug) do
    case course_slug do
      "seven-day-neverfap-deluxe-kickstarter" -> :seven_day_kickstarter_up_to_count
      "ten-day-meditation-primer" -> :ten_day_meditation_up_to_count
      "twenty-eight-day-awareness-challenge" -> :twenty_eight_day_awareness_up_to_count
      "seven-week-awareness-challenge-vol-1" -> :seven_week_awareness_vol_1_up_to_count
      "seven-week-awareness-challenge-vol-2" -> :seven_week_awareness_vol_2_up_to_count
      "seven-week-awareness-challenge-vol-3" -> :seven_week_awareness_vol_3_up_to_count
      "seven-week-awareness-challenge-vol-4" -> :seven_week_awareness_vol_4_up_to_count
    end
  end

  def page_symbol_to_up_to_count(page_symbol) do
    case page_symbol do
      :seven_day_kickstarter_single -> :seven_day_kickstarter_up_to_count
      :ten_day_meditation_single -> :ten_day_meditation_up_to_count
      :twenty_eight_day_awareness_single -> :twenty_eight_day_awareness_up_to_count
      :seven_week_awareness_vol_1_single -> :seven_week_awareness_vol_1_up_to_count
      :seven_week_awareness_vol_2_single -> :seven_week_awareness_vol_2_up_to_count
      :seven_week_awareness_vol_3_single -> :seven_week_awareness_vol_3_up_to_count
      :seven_week_awareness_vol_4_single -> :seven_week_awareness_vol_4_up_to_count
    end
  end

  def page_symbol_subscribed_to_slug(page_symbol) do
    case page_symbol do
      :seven_day_kickstarter_subscribed -> "seven-day-neverfap-deluxe-kickstarter"
      :ten_day_meditation_subscribed -> "ten-day-meditation-primer"
      :twenty_eight_day_awareness_subscribed -> "twenty-eight-day-awareness-challenge"
      :seven_week_awareness_vol_1_subscribed -> "seven-week-awareness-challenge-vol-1"
      :seven_week_awareness_vol_2_subscribed -> "seven-week-awareness-challenge-vol-2"
      :seven_week_awareness_vol_3_subscribed -> "seven-week-awareness-challenge-vol-3"
      :seven_week_awareness_vol_4_subscribed -> "seven-week-awareness-challenge-vol-4"
    end
  end

  def collection_slug_to_subscribed_property(collection_slug) do
    case collection_slug do
      "seven-day-neverfap-deluxe-kickstarter" -> :seven_day_kickstarter_subscribed
      "ten-day-meditation-primer" -> :ten_day_meditation_subscribed
      "twenty-eight-day-awareness-challenge" -> :twenty_eight_day_awareness_subscribed
      "seven-week-awareness-challenge-vol-1" -> :seven_week_awareness_vol_1_subscribed
      "seven-week-awareness-challenge-vol-2" -> :seven_week_awareness_vol_2_subscribed
      "seven-week-awareness-challenge-vol-3" -> :seven_week_awareness_vol_3_subscribed
      "seven-week-awareness-challenge-vol-4" -> :seven_week_awareness_vol_4_subscribed
    end
  end
  
  def content_symbol_to_page_symbol(content_symbol) do
    case content_symbol do 
      :article -> :articles
      :practice -> :practices
      :podcast -> :podcasts
      :quote -> :quotes
      :meditation -> :meditations
      :blog -> :blogs
      :update -> :updates
      :seven_day_kickstarter -> :seven_day_kickstarter_single
      :ten_day_meditation -> :ten_day_meditation_single
      :twenty_eight_day_awareness -> :twenty_eight_day_awareness_single
      :seven_week_awareness_vol_1 -> :seven_week_awareness_vol_1_single
      :seven_week_awareness_vol_2 -> :seven_week_awareness_vol_2_single
      :seven_week_awareness_vol_3 -> :seven_week_awareness_vol_3_single
      :seven_week_awareness_vol_4 -> :seven_week_awareness_vol_4_single
    end
  end

  # defp generate_seven_week_awareness_challenge_title(vol) do
  #   case vol do
  #     "1" -> "7 Week Awareness Challenge Vol 1."
  #     "2" -> "7 Week Awareness Challenge Vol 2."
  #     "3" -> "7 Week Awareness Challenge Vol 3."
  #     "4" -> "7 Week Awareness Challenge Vol 4."
  #     "5" -> "7 Week Awareness Challenge Vol 5."
  #     "6" -> "7 Week Awareness Challenge Vol 6."
  #     _ -> nil
  #   end
  # end
end





