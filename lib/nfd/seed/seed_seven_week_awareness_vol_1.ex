defmodule Nfd.SeedSWAVOL1 do
  alias Nfd.Repo
  # import Ecto

  alias Nfd.Content
  alias Nfd.Content.File
  alias Nfd.Content.Collection

  def seed do
    case Content.get_collection_seed_id("fd5bf9cf-a0db-41c9-af52-c482f4701384") do
      nil ->
        collection = Repo.insert!(%Collection{
          seed_id: "fd5bf9cf-a0db-41c9-af52-c482f4701384",
          type: "course_collection",
          active_type: "awareness_active_type",
          frequency: "week",
          total_period: 7,
          status: "in_progress",
          stripe_description: "Learn more about your awareness with Vol 1. of our 7 week awareness challenge.",
          benefit_list: "7 Awareness Audio Recordings;Additional Written Explanations",
          subscribed_property_string: "awareness_seven_week_vol_1_subscribed",
          description: "Learn more about your awareness with Vol 1. of our 7 week awareness challenge.",
          display_name: "7 Week Awareness Challenge Vol 1.",
          cover_image: "/images/ebook_covers/vol1-ebook-cover-600-900.png",
          premium: true,
          price: 14.99,
          slug: "seven-week-awareness-challenge-vol-1"
        })
      seven_week_awareness_vol_1_files(collection.id)

      _collection -> nil
    end
  end

  def seven_week_awareness_vol_1_files(collection_id) do
    Repo.insert(%File{
      seed_id: "dd5b4c6f-b8b1-4a2e-b30d-4bd7f081f9d2",
      type: "audio_file", specific_type: "mp3",
      description: "Week 1",
      display_name: "Expressing Gratitude",
      number: 1,
      premium: true,
      b2_file_name: "swac-vol-1-ep-01-expressing-gratitude.mp3",
      slug: "expressing-gratitude",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "2ce626da-3930-4d2d-b394-3a8e52dd1f73",
      type: "audio_file", specific_type: "mp3",
      description: "Week 2",
      display_name: "Focus On Your Finger And Your Background",
      number: 2,
      premium: true,
      b2_file_name: "swac-vol-1-ep-02-focus-on-your-finger-and-your-background.mp3",
      slug: "focus-on-your-finger-and-your-background",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "aa792de7-e471-4d82-9215-dc73aeb94689",
      type: "audio_file", specific_type: "mp3",
      description: "Week 3",
      display_name: "Relax Everything",
      number: 3,
      premium: true,
      b2_file_name: "swac-vol-1-ep-03-relax-everything.mp3",
      slug: "relax-everything",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "af235f37-b0c4-4bc9-a171-9f71788b106c",
      type: "audio_file", specific_type: "mp3",
      description: "Week 4",
      display_name: "Slow Down Time",
      number: 4,
      premium: true,
      b2_file_name: "swac-vol-1-ep-04-slow-down-time.mp3",
      slug: "slow-down-time",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "969f1b8d-1cfb-4112-a926-7a52eb4907db",
      type: "audio_file", specific_type: "mp3",
      description: "Week 5",
      display_name: "Identify Points Of Awareness Throughout The Day",
      number: 5,
      premium: true,
      b2_file_name: "swac-vol-1-ep-05-identify-points-of-awareness-throughout-your-day.mp3",
      slug: "identify-points-of-awareness-throughout-your-day",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "88975891-0011-4d5e-a537-eb83dc9f4a9e",
      type: "audio_file", specific_type: "mp3",
      description: "Week 6",
      display_name: "Can You Look Through Walls?",
      number: 6,
      premium: true,
      b2_file_name: "01-swac-vol-1-ep-06-can-you-look-through-walls.mp3",
      slug: "can-you-look-through-walls",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "053b4085-6673-464c-8665-283317077d7b",
      type: "audio_file", specific_type: "mp3",
      description: "Week 7",
      display_name: "Looking Straight Ahead",
      number: 7,
      premium: true,
      b2_file_name: "01-swac-vol-1-ep-07-looking-straight-ahead.mp3",
      slug: "looking-straight-ahead",
      collection_id: collection_id
    })
  end
end
