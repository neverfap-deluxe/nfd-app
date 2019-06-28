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
          course_config_type: "awareness_week_vol_4",
          frequency: "week",
          total_period: 7,
          status: "in_progress",
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
        seven_week_awareness_vol_4_ebook_files(collection.id) 
        seven_week_awareness_vol_4_audio_files(collection.id)

      _collection -> nil
    end
  end

  def seven_week_awareness_vol_4_ebook_files(collection_id) do
    Repo.insert(%File{
      seed_id: "17753806-0880-4cbb-80e2-6dac28992939",
      type: "ebook_file",
      specific_type: "epub",
      description: "",
      display_name: "7 Week Awareness Challenge Vol 4. epub",
      b2_file_name: "seven-week-awareness-challenge-vol-4.epub",
      number: -666,
      premium: false,
      slug: "seven-week-awareness-challenge-vol-4-epub",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "40a6509c-9911-40bd-9ecc-d2f2736a8ec4",
      type: "ebook_file",
      specific_type: "pdf",
      description: "",
      display_name: "7 Week Awareness Challenge Vol 4. pdf",
      b2_file_name: "seven-week-awareness-challenge-vol-4.pdf",
      number: -666,
      premium: false,
      slug: "seven-week-awareness-challenge-vol-4-pdf",
      collection_id: collection_id
    })
  end

  def seven_week_awareness_vol_4_audio_files(collection_id) do
    Repo.insert(%File{
      seed_id: "111b4c6f-b8b1-4a2e-b30d-4bd7f081f9d2",
      type: "email_file",
      specific_type: "email",
      description: "Week 0",
      display_name: "Introduction",
      number: 0,
      premium: true,
      b2_file_name: "",
      slug: "introduction",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "5592b769-cb4f-4e45-8c13-c463df3ccec3",
      type: "audio_file", specific_type: "mp3",
      description: "Week 1",
      display_name: "Annoy Yourself",
      number: 1,
      premium: true,
      b2_file_name: "swac-vol-4-ep-01-annoy-yourself.mp3",
      slug: "annoy-yourself",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "2a9559cf-2198-4caf-b88c-5cf2df697bb8",
      type: "audio_file", specific_type: "mp3",
      description: "Week 2",
      display_name: "Just Do, Don't Think",
      number: 2,
      premium: true,
      b2_file_name: "swac-vol-4-ep-02-just-do-dont-think.mp3",
      slug: "just-do-dont-think",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "30f9071f-afd2-47a8-9338-b263335539dd",
      type: "audio_file", specific_type: "mp3",
      description: "Week 3",
      display_name: "Fighting Spirit",
      number: 3,
      premium: true,
      b2_file_name: "swac-vol-4-ep-03-fighting-spirit.mp3",
      slug: "fighting-spirit",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "8b0c47dd-be8d-424f-b946-4aba5203fa16",
      type: "audio_file", specific_type: "mp3",
      description: "Week 4",
      display_name: "Every 30 Minutes",
      number: 4,
      premium: true,
      b2_file_name: "swac-vol-4-ep-04-every-30-minutes.mp3",
      slug: "every-30-minutes",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "5fad0f7c-bb1b-4787-b5bd-3343c11e99cb",
      type: "audio_file", specific_type: "mp3",
      description: "Week 5",
      display_name: "Control The Intonation Of Your Breath",
      number: 5,
      premium: true,
      b2_file_name: "swac-vol-4-ep-05-control-the-intonation-of-your-breath.mp3",
      slug: "control-the-intonation-of-your-breath",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "efca617b-18f8-44db-989d-fb94a3d6180a",
      type: "audio_file", specific_type: "mp3",
      description: "Week 6",
      display_name: "Catching The Odd Judge Out",
      number: 6,
      premium: true,
      b2_file_name: "swac-vol-4-ep-06-catching-the-odd-judge-out.mp3",
      slug: "catching-the-odd-judge-out",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "9ba1372a-0f75-4374-ac95-81a5527093dc",
      type: "audio_file", specific_type: "mp3",
      description: "Week 7",
      display_name: "Focus Your Attention",
      number: 7,
      premium: true,
      b2_file_name: "swac-vol-4-ep-07-focus-your-attention.mp3",
      slug: "focus-your-attention",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "5e2afb9a-3a53-40b8-b10d-a6e8961cd8a2",
      type: "email_file",
      specific_type: "email",
      description: "Conclusion",
      display_name: "Conclusion",
      number: 8,
      premium: true,
      b2_file_name: "",
      slug: "conclusion",
      collection_id: collection_id
    })
  end
end
