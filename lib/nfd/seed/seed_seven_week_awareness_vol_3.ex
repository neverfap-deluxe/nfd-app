defmodule Nfd.SeedSWAVOL3 do
  alias Nfd.Repo
  # import Ecto

  alias Nfd.Content
  alias Nfd.Content.File
  alias Nfd.Content.Collection

  def seed do
    case Content.get_collection_seed_id("c014f1c5-be89-455f-8f88-970c6cf70d5d") do
      nil ->
        collection = Repo.insert!(%Collection{
          seed_id: "c014f1c5-be89-455f-8f88-970c6cf70d5d",
          type: "course_collection",
          active_type: "awareness_active_type",
          frequency: "week",
          total_period: 7,
          status: "in_progress",
          stripe_sku: "NA",
          stripe_description: "Learn more about your awareness with Vol 3. of our 7 week awareness challenge.",
          benefit_list: "7 Awareness Audio Recordings;Additional Written Explanations",
          subscribed_property_string: "awareness_seven_week_vol_3_subscribed",
          description: "Learn more about your awareness with Vol 3. of our 7 week awareness challenge.",
          display_name: "7 Week Awareness Challenge Vol 3.",
          cover_image: "/images/ebook_covers/vol3-ebook-cover-600-900.png",
          premium: true,
          price: 14.99,
          slug: "seven-week-awareness-challenge-vol-3"
        })
        seven_week_awareness_vol_3_files(collection.id)

      _collection -> nil
    end
  end

  def seven_week_awareness_vol_3_files(collection_id) do
    Repo.insert(%File{
      seed_id: "9538ad08-ce36-4513-a150-2c9bf7e791a7",
      type: "audio_file", specific_type: "mp3",
      description: "Week 1",
      display_name: "Where Do You Touch?",
      bucket_name: "swavol3",
      b2_file_name: "", number: 1,
      premium: true,
      slug: "where-do-you-touch",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "3bf3527c-3cf8-4939-bf80-82b9b87f80cf",
      type: "audio_file", specific_type: "mp3",
      description: "Week 2",
      display_name: "Use Your Opposite Hand",
      bucket_name: "swavol3",
      b2_file_name: "", number: 2,
      premium: true,
      slug: "use-your-opposite-hand",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "1e3c3c70-6f2c-4b77-8c5c-2212ccbdc892",
      type: "audio_file", specific_type: "mp3",
      description: "Week 3",
      display_name: "Who Is Looking?",
      bucket_name: "swavol3",
      b2_file_name: "", number: 3,
      premium: true,
      slug: "who-is-looking",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "b34ecae6-ae6c-440f-831c-f035f4f33ab5",
      type: "audio_file", specific_type: "mp3",
      description: "Week 4",
      display_name: "Identifying The Feeling Of Obligation",
      bucket_name: "swavol3",
      b2_file_name: "", number: 4,
      premium: true,
      slug: "identifying-the-feeling-of-obligation",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "95e53cea-95b8-4a28-9458-f33f4f127eb5",
      type: "audio_file", specific_type: "mp3",
      description: "Week 5",
      display_name: "Engaging Expression",
      bucket_name: "swavol3",
      b2_file_name: "", number: 5,
      premium: true,
      slug: "engaging-expression",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "3d7a52d7-dbb2-4e5f-a483-7268c36e7823",
      type: "audio_file", specific_type: "mp3",
      description: "Week 6",
      display_name: "Object Attachment",
      bucket_name: "swavol3",
      b2_file_name: "", number: 6,
      premium: true,
      slug: "object-attachment",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "29c38a9f-4b45-434b-9879-7bed344216b6",
      type: "audio_file", specific_type: "mp3",
      description: "Week 7",
      display_name: "Slow Spinning Circle",
      bucket_name: "swavol3",
      b2_file_name: "", number: 7,
      premium: true,
      slug: "slow-spinning-circle",
      collection_id: collection_id
    })
  end
end
