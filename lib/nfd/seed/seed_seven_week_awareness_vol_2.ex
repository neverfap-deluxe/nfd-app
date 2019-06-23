defmodule Nfd.SeedSWAVOL2 do
  alias Nfd.Repo
  # import Ecto

  alias Nfd.Content
  alias Nfd.Content.File
  alias Nfd.Content.Collection

  def seed do
    case Content.get_collection_seed_id("d5d2c8c4-b90e-4556-8089-feb0dfc212fd") do
      nil ->
        collection = Repo.insert!(%Collection{
          seed_id: "d5d2c8c4-b90e-4556-8089-feb0dfc212fd",
          type: "course_collection",
          active_type: "awareness_active_type",
          status: "in_progress",
          stripe_sku: "NA",
          stripe_description: "Learn more about your awareness with Vol 2. of our 7 week awareness challenge.",
          benefit_list: "7 Awareness Audio Recordings;Additional Written Explanations",
          subscribed_property_string: "awareness_seven_week_vol_2_subscribed",
          description: "Learn more about your awareness with Vol 2. of our 7 week awareness challenge.",
          display_name: "7 Week Awareness Challenge Vol 2.",
          cover_image: "/images/ebook_covers/vol2-ebook-cover-600-900.png",
          premium: true,
          price: 14.99,
          slug: "seven-week-awareness-challenge-vol-2"
        })
        seven_week_awareness_vol_2_files(collection.id)

      _collection -> nil
    end
  end

  def seven_week_awareness_vol_2_files(collection_id) do
    Repo.insert(%File{
      seed_id: "c895bf5c-cc00-4576-9729-adea07c63597",
      type: "audio_file",
      description: "Week 1",
      display_name: "Take Note Of The Colour Yellow",
      bucket_name: "swavol2",
      file_url: "", # TODO
      premium: true,
      slug: "take-note-of-the-colour-yellow",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "ab0f8449-8c95-4dd0-8231-ac7796572785",
      type: "audio_file",
      description: "Week 2",
      display_name: "Dissolve Your Visual Field",
      bucket_name: "swavol2",
      file_url: "", # TODO
      premium: true,
      slug: "dissolve-your-visual-field",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "e04110e6-c6a4-4b06-9c06-c1ef2c4c0ead",
      type: "audio_file",
      description: "Week 3",
      display_name: "Catch Out Your Judgements",
      bucket_name: "swavol2",
      file_url: "", # TODO
      premium: true,
      slug: "catch-out-your-judgements",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "770784e1-698d-4974-836f-9f4b10a64f30",
      type: "audio_file",
      description: "Week 4",
      display_name: "What Can Your Hand Do?",
      bucket_name: "swavol2",
      file_url: "", # TODO
      premium: true,
      slug: "what-can-your-hand-do",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "831957e9-2f06-441b-81e4-f6280069dfcc",
      type: "audio_file",
      description: "Week 5",
      display_name: "Stop Absolutely Everything You're Doing",
      bucket_name: "swavol2",
      file_url: "", # TODO
      premium: true,
      slug: "stop-absolutely-everything-you-are-doing",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "03e41b4b-08a8-4f48-bc6f-0cf70c9ab851",
      type: "audio_file",
      description: "Week 6",
      display_name: "Developing Routine",
      bucket_name: "swavol2",
      file_url: "", # TODO
      premium: true,
      slug: "developing-routine",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "31a368fd-de36-497d-9bfe-077a028ecdaa",
      type: "audio_file",
      description: "Week 7",
      display_name: "Blind Attention",
      bucket_name: "swavol2",
      file_url: "", # TODO
      premium: true,
      slug: "blind-attention",
      collection_id: collection_id
    })
  end
end
