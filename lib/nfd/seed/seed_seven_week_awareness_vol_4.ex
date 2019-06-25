defmodule Nfd.SeedSWAVOL4 do
  alias Nfd.Repo
  # import Ecto

  alias Nfd.Content
  alias Nfd.Content.File
  alias Nfd.Content.Collection

  def seed do
    case Content.get_collection_seed_id("b9bb282c-5238-4377-90e1-825de279376c") do
      nil ->
        collection = Repo.insert!(%Collection{
          seed_id: "b9bb282c-5238-4377-90e1-825de279376c",
          type: "course_collection",
          active_type: "awareness_active_type",
          frequency: "week",
          total_period: 7,
          status: "in_progress",
          stripe_sku: "NA",
          stripe_description: "Learn more about your awareness with Vol 4. of our 7 week awareness challenge.",
          benefit_list: "7 Awareness Audio Recordings;Additional Written Explanations",
          subscribed_property_string: "awareness_seven_week_vol_4_subscribed",
          description: "Learn more about your awareness with Vol 4. of our 7 week awareness challenge.",
          display_name: "7 Week Awareness Challenge Vol 4.",
          cover_image: "/images/ebook_covers/vol4-ebook-cover-600-900.png",
          premium: true,
          price: 14.99,
          slug: "seven-week-awareness-challenge-vol-4"
        })
        seven_week_awareness_vol_4_files(collection.id)

      _collection -> nil
    end
  end

  def seven_week_awareness_vol_4_files(collection_id) do
    Repo.insert(%File{
      seed_id: "5592b769-cb4f-4e45-8c13-c463df3ccec3",
      type: "audio_file", specific_type: "mp3",
      description: "Week 1",
      display_name: "Annoy Yourself",
      bucket_name: "swavol3",
      b2_file_name: "", number: 1,
      premium: true,
      slug: "annoy-yourself",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "2a9559cf-2198-4caf-b88c-5cf2df697bb8",
      type: "audio_file", specific_type: "mp3",
      description: "Week 2",
      display_name: "Just Do, Don't Think",
      bucket_name: "swavol3",
      b2_file_name: "", number: 2,
      premium: true,
      slug: "just-do-dont-think",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "30f9071f-afd2-47a8-9338-b263335539dd",
      type: "audio_file", specific_type: "mp3",
      description: "Week 3",
      display_name: "Fighting Spirit",
      bucket_name: "swavol3",
      b2_file_name: "", number: 3,
      premium: true,
      slug: "fighting-spirit",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "8b0c47dd-be8d-424f-b946-4aba5203fa16",
      type: "audio_file", specific_type: "mp3",
      description: "Week 4",
      display_name: "Every 30 Minutes",
      bucket_name: "swavol3",
      b2_file_name: "", number: 4,
      premium: true,
      slug: "every-30-minutes",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "5fad0f7c-bb1b-4787-b5bd-3343c11e99cb",
      type: "audio_file", specific_type: "mp3",
      description: "Week 5",
      display_name: "Control The Intonation Of Your Breath",
      bucket_name: "swavol3",
      b2_file_name: "", number: 5,
      premium: true,
      slug: "control-the-intonation-of-your-breath",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "efca617b-18f8-44db-989d-fb94a3d6180a",
      type: "audio_file", specific_type: "mp3",
      description: "Week 6",
      display_name: "Catching The Odd Judge Out",
      bucket_name: "swavol3",
      b2_file_name: "", number: 6,
      premium: true,
      slug: "catching-the-odd-judge-out",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "9ba1372a-0f75-4374-ac95-81a5527093dc",
      type: "audio_file", specific_type: "mp3",
      description: "Week 7",
      display_name: "Focus Your Attention",
      bucket_name: "swavol3",
      b2_file_name: "", number: 7,
      premium: true,
      slug: "focus-your-attention",
      collection_id: collection_id
    })
  end
end
