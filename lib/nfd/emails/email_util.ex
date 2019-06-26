defmodule Nfd.Util.Email do
  def validate_multiple_matrix(matrix) do
    validation_object = Enum.map(String.split(matrix, "-"), fn(main_matrix) ->
      case String.split(main_matrix, "h") do
        [x, pos] when x in ["0", "1", "2", "3", "4", "5", "6", "7"] and pos in ["0", "1", "2"] -> true
        [_, _] -> false
      end
    end)

    case validation_object do
      [true] -> true
      [true, true] -> true
      [_] -> false
      [_, _] -> false
    end
  end
  def validate_subscriber_is_already_subscribed(subscriber, main_matrix) do
    case String.split(main_matrix, "h") do
      ["0", _] -> subscriber.subscribed == true
      ["1", _] -> subscriber.seven_day_kickstarter_subscribed == true
      ["2", _] -> subscriber.ten_day_meditation_subscribed == true
      ["3", _] -> subscriber.twenty_eight_day_awareness_subscribed == true
      ["4", _] -> subscriber.awareness_seven_week_vol_1_type == true
      ["5", _] -> subscriber.awareness_seven_week_vol_2_type == true
      ["6", _] -> subscriber.awareness_seven_week_vol_3_type == true
      ["7", _] -> subscriber.awareness_seven_week_vol_4_type == true
    end
  end
  def main_matrix_to_type(main_matrix) do
    # [Value, Position]
    # Value: 0 - general, 1 kickstarter, 2 meditation, 3 awareness,
    # Position: 0 - do nothing, 1 subscribe, 2 unsubscribe
    # "0h1-1h1" #value 0, pos 1; value 1, pos 1;
    { general_type, kickstarter_type, meditation_primer_type, awareness_challenge_type, awareness_seven_week_vol_1_type, awareness_seven_week_vol_2_type, awareness_seven_week_vol_3_type, awareness_seven_week_vol_4_type } = Nfd.Util.Email.generate_course_types()

    case String.split(main_matrix, "h") do
      ["0", _] -> general_type
      ["1", _] -> kickstarter_type
      ["2", _] -> meditation_primer_type
      ["3", _] -> awareness_challenge_type
      ["4", _] -> awareness_seven_week_vol_1_type
      ["5", _] -> awareness_seven_week_vol_2_type
      ["6", _] -> awareness_seven_week_vol_3_type
      ["7", _] -> awareness_seven_week_vol_4_type
    end
  end
  def main_matrix_to_collection_seed_id(main_matrix) do
    case String.split(main_matrix, "h") do
      ["0", _] -> nil # This doesn't exist
      ["1", _] -> "068b52c1-cce1-4239-a345-1182ae528a41"
      ["2", _] -> "943bd030-60e4-42da-a8c1-0c926c508374"
      ["3", _] -> "12ec4d76-3d93-42c5-8c2f-65bb146e4bd6"
      ["4", _] -> ""
      ["5", _] -> ""
      ["6", _] -> ""
      ["7", _] -> ""
    end
  end
  def main_matrix_to_type_and_action(main_matrix) do
    { general_type, kickstarter_type, meditation_primer_type, awareness_challenge_type, awareness_seven_week_vol_1_type, awareness_seven_week_vol_2_type, awareness_seven_week_vol_3_type, awareness_seven_week_vol_4_type } = Nfd.Util.Email.generate_course_types()

    case String.split(main_matrix, "h") do
      ["0", "0"] -> { general_type, :nothing }
      ["0", "1"] -> { general_type, :subscribe }
      ["0", "2"] -> { general_type, :unsubscribe }
      ["1", "0"] -> { kickstarter_type, :nothing }
      ["1", "1"] -> { kickstarter_type, :subscribe }
      ["1", "2"] -> { kickstarter_type, :unsubscribe }
      ["2", "0"] -> { meditation_primer_type, :nothing }
      ["2", "1"] -> { meditation_primer_type, :subscribe }
      ["2", "2"] -> { meditation_primer_type, :unsubscribe }
      ["3", "0"] -> { awareness_challenge_type, :nothing }
      ["3", "1"] -> { awareness_challenge_type, :subscribe }
      ["3", "2"] -> { awareness_challenge_type, :unsubscribe }
      ["4", "0"] -> { awareness_seven_week_vol_1_type, :nothing }
      ["4", "1"] -> { awareness_seven_week_vol_1_type, :subscribe }
      ["4", "2"] -> { awareness_seven_week_vol_1_type, :unsubscribe }
      ["5", "0"] -> { awareness_seven_week_vol_2_type, :nothing }
      ["5", "1"] -> { awareness_seven_week_vol_2_type, :subscribe }
      ["5", "2"] -> { awareness_seven_week_vol_2_type, :unsubscribe }
      ["6", "0"] -> { awareness_seven_week_vol_3_type, :nothing }
      ["6", "1"] -> { awareness_seven_week_vol_3_type, :subscribe }
      ["6", "2"] -> { awareness_seven_week_vol_3_type, :unsubscribe }
      ["7", "0"] -> { awareness_seven_week_vol_4_type, :nothing }
      ["7", "1"] -> { awareness_seven_week_vol_4_type, :subscribe }
      ["7", "2"] -> { awareness_seven_week_vol_4_type, :unsubscribe }
    end
  end
  def type_to_subscriber_properties(type) do
    { general_type, kickstarter_type, meditation_primer_type, awareness_challenge_type, awareness_seven_week_vol_1_type, awareness_seven_week_vol_2_type, awareness_seven_week_vol_3_type, awareness_seven_week_vol_4_type } = Nfd.Util.Email.generate_course_types()

    case type do
      ^general_type -> {:NA, :NA, :NA, :subscribed}
      ^kickstarter_type -> {:seven_day_kickstarter_count, :seven_day_kickstarter_up_to_count, :free_active, :seven_day_kickstarter_subscribed}
      ^meditation_primer_type -> {:ten_day_meditation_count, :ten_day_meditation_up_to_count, :meditation_active, :ten_day_meditation_subscribed}
      ^awareness_challenge_type -> {:twenty_eight_day_awareness_count, :twenty_eight_day_awareness_up_to_count, :awareness_active, :twenty_eight_day_awareness_subscribed}
      ^awareness_seven_week_vol_1_type -> {:awareness_seven_week_vol_1_count, :awareness_seven_week_vol_1_up_to_count, :awareness_active, :awareness_seven_week_vol_1_subscribed}
      ^awareness_seven_week_vol_2_type -> {:awareness_seven_week_vol_2_count, :awareness_seven_week_vol_2_up_to_count, :awareness_active, :awareness_seven_week_vol_2_subscribed}
      ^awareness_seven_week_vol_3_type -> {:awareness_seven_week_vol_3_count, :awareness_seven_week_vol_3_up_to_count, :awareness_active, :awareness_seven_week_vol_3_subscribed}
      ^awareness_seven_week_vol_4_type -> {:awareness_seven_week_vol_4_count, :awareness_seven_week_vol_4_up_to_count, :awareness_active, :awareness_seven_week_vol_4_subscribed}
    end
  end
  def type_to_collection_slug(type) do
    { general_type, kickstarter_type, meditation_primer_type, awareness_challenge_type, awareness_seven_week_vol_1_type, awareness_seven_week_vol_2_type, awareness_seven_week_vol_3_type, awareness_seven_week_vol_4_type } = Nfd.Util.Email.generate_course_types()
    case type do
      ^general_type -> "general-newsletter"
      ^kickstarter_type -> "seven-day-neverfap-deluxe-kickstarter"
      ^meditation_primer_type -> "ten-day-meditation-primer"
      ^awareness_challenge_type -> "twenty-eight-day-awareness-challenge"
      ^awareness_seven_week_vol_1_type -> "seven-week-awareness-challenge-vol-1"
      ^awareness_seven_week_vol_2_type -> "seven-week-awareness-challenge-vol-2"
      ^awareness_seven_week_vol_3_type -> "seven-week-awareness-challenge-vol-3"
      ^awareness_seven_week_vol_4_type -> "seven-week-awareness-challenge-vol-4"
    end
  end
  def collection_slug_to_type(collection_slug) do
    { general_type, kickstarter_type, meditation_primer_type, awareness_challenge_type, awareness_seven_week_vol_1_type, awareness_seven_week_vol_2_type, awareness_seven_week_vol_3_type, awareness_seven_week_vol_4_type } = Nfd.Util.Email.generate_course_types()
    cond do
      collection_slug == "general-newsletter" -> general_type
      collection_slug == "seven-day-neverfap-deluxe-kickstarter" -> kickstarter_type
      collection_slug == "ten-day-meditation-primer" -> meditation_primer_type
      collection_slug == "twenty-eight-day-awareness-challenge" -> awareness_challenge_type
      collection_slug == "seven-week-awareness-challenge-vol-1"-> awareness_seven_week_vol_1_type
      collection_slug == "seven-week-awareness-challenge-vol-2"-> awareness_seven_week_vol_2_type
      collection_slug == "seven-week-awareness-challenge-vol-3"-> awareness_seven_week_vol_3_type
      collection_slug == "seven-week-awareness-challenge-vol-4"-> awareness_seven_week_vol_4_type
    end
  end
  def collection_slug_to_active_type_property(collection_slug) do
    cond do
      "general-newsletter" -> :NA
      "seven-day-neverfap-deluxe-kickstarter" -> :free_active
      "ten-day-meditation-primer" -> :meditation_active
      "twenty-eight-day-awareness-challenge" -> :awareness_active
      "seven-week-awareness-challenge-vol-1"-> :awareness_active
      "seven-week-awareness-challenge-vol-2"-> :awareness_active
      "seven-week-awareness-challenge-vol-3"-> :awareness_active
      "seven-week-awareness-challenge-vol-4"-> :awareness_active
    end
  end
  def collection_slug_to_subscribed_property(collection_slug) do
    type = collection_slug_to_type(collection_slug)
    type_to_subscriber_properties(type)
  end
  def generate_confirmation_url(email, multiple_matrix, main_matrix), do: "#{NfdWeb.Endpoint.url()}/subscription_success?subscriber_email=#{email}&multiple_matrix=#{multiple_matrix}&main_matrix=#{main_matrix}"
  def generate_unsubscribe_url(main_matrix, email), do: "#{NfdWeb.Endpoint.url()}/unsubscribe?subscriber_email=#{email}&main_matrix=#{main_matrix}"
  def generate_course_name_from_type(type) do
    { general_type, kickstarter_type, meditation_primer_type, awareness_challenge_type, awareness_seven_week_vol_1_type, awareness_seven_week_vol_2_type, awareness_seven_week_vol_3_type, awareness_seven_week_vol_4_type } = Nfd.Util.Email.generate_course_types()

    case type do
      ^general_type -> "General Newsletter"
      ^kickstarter_type -> "7 Day NeverFap Deluxe Kickstarter"
      ^meditation_primer_type -> "10 Day Meditation Primer"
      ^awareness_challenge_type -> "28 Day Awareness Challenge"
      ^awareness_seven_week_vol_1_type -> "7 Week Awareness Challenge Vol 1"
      ^awareness_seven_week_vol_2_type -> "7 Week Awareness Challenge Vol 2"
      ^awareness_seven_week_vol_3_type -> "7 Week Awareness Challenge Vol 3"
      ^awareness_seven_week_vol_4_type -> "7 Week Awareness Challenge Vol 4"
    end
  end
  def course_type_to_matrix(type) do
    { general_type, kickstarter_type, meditation_primer_type, awareness_challenge_type, awareness_seven_week_vol_1_type, awareness_seven_week_vol_2_type, awareness_seven_week_vol_3_type, awareness_seven_week_vol_4_type } = Nfd.Util.Email.generate_course_types()
    case type do
      ^general_type -> "0h1"
      ^kickstarter_type -> "1h1"
      ^meditation_primer_type -> "2h1"
      ^awareness_challenge_type -> "3h1"
      ^awareness_seven_week_vol_1_type -> "4h1"
      ^awareness_seven_week_vol_2_type -> "5h1"
      ^awareness_seven_week_vol_3_type -> "6h1"
      ^awareness_seven_week_vol_4_type -> "7h1"
    end
  end
  def collection_slug_to_matrix(type) do
    case type do
       "general-newsletter" -> "0h1"
       "seven-day-neverfap-deluxe-kickstarter" -> "1h1"
       "ten-day-meditation-primer" -> "2h1"
       "twenty-eight-day-awareness-challenge" -> "3h1"
       "seven-week-awareness-challenge-vol-1" -> "4h1"
       "seven-week-awareness-challenge-vol-2" -> "5h1"
       "seven-week-awareness-challenge-vol-3" -> "6h1"
       "seven-week-awareness-challenge-vol-4" -> "7h1"
    end
  end
  def collection_slug_to_count_property(type) do
    case type do
       "general-newsletter" -> :na
       "seven-day-neverfap-deluxe-kickstarter" -> :seven_day_kickstarter_count
       "ten-day-meditation-primer" -> :ten_day_meditation_count
       "twenty-eight-day-awareness-challenge" -> :twenty_eight_day_awareness_count
       "seven-week-awareness-challenge-vol-1" -> :awareness_seven_week_vol_1_count
       "seven-week-awareness-challenge-vol-2" -> :awareness_seven_week_vol_2_count
       "seven-week-awareness-challenge-vol-3" -> :awareness_seven_week_vol_3_count
       "seven-week-awareness-challenge-vol-4" -> :awareness_seven_week_vol_4_count
    end
  end
  def generate_course_types do
    { Application.get_env(:nfd, :general_type),
      Application.get_env(:nfd, :kickstarter_type),
      Application.get_env(:nfd, :meditation_primer_type),
      Application.get_env(:nfd, :awareness_challenge_type),
      Application.get_env(:nfd, :awareness_seven_week_vol_1_type),
      Application.get_env(:nfd, :awareness_seven_week_vol_2_type),
      Application.get_env(:nfd, :awareness_seven_week_vol_3_type),
      Application.get_env(:nfd, :awareness_seven_week_vol_4_type) }
  end
end
