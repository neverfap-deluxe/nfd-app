defmodule Nfd.SeedTDMP do
  alias Nfd.Repo
  # import Ecto

  alias Nfd.Content
  alias Nfd.Content.File
  alias Nfd.Content.Collection

  def seed do
    case Content.get_collection_seed_id("943bd030-60e4-42da-a8c1-0c926c508374") do
      nil ->
        collection = Repo.insert!(%Collection{
          seed_id: "943bd030-60e4-42da-a8c1-0c926c508374",
          type: "course_collection",
          active_type: "meditation_active_type",
          frequency: "day",
          total_period: 10,
          status: "complete",
          stripe_description: "10 Day Meditation Primer Audio Series.",
          benefit_list: "10 Guided Meditation Recordings;For Beginners",
          subscribed_property_string: "ten_day_meditation_subscribed",
          description: "Want to learn more about meditation and best practices? The 10 day meditation primer is an excellent place to start.",
          display_name: "10 Day Meditation Primer",
          cover_image: "/images/ebook_covers/ten-day-meditation-ebook-cover-600-900.png",
          premium: true,
          price: 9.99,
          slug: "ten-day-meditation-primer"
        })
        ten_day_meditation_files(collection.id)

      _collection -> nil
    end
  end

  def ten_day_meditation_files(collection_id) do
    Repo.insert(%File{
      seed_id: "36652b93-34e9-4bf8-8b15-97aab73fbeeb",
      type: "audio_file", specific_type: "mp3",
      description: "Day 1",
      display_name: "Meditation Basics",
      number: 1,
      premium: true,
      b2_file_name: "tdmp-ep-01-meditation-basics.mp3",
      slug: "meditation-basics",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "8aa47f35-ee3a-47e9-938c-48f61f24a893",
      type: "audio_file", specific_type: "mp3",
      description: "Day 2",
      display_name: "Understanding The Purpose Of Meditation",
      number: 2,
      premium: true,
      b2_file_name: "tdmp-ep-01-understanding-the-purpose-of-meditation.mp3",
      slug: "understanding-the-purpose-of-meditation",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "ef587626-1c38-48a9-9128-567585bea7a6",
      type: "audio_file", specific_type: "mp3",
      description: "Day 3",
      display_name: "Developing Our Capacity For Awareness",
      number: 3,
      premium: true,
      b2_file_name: "tdmp-ep-01-developing-our-capacity-for-awareness.mp3",
      slug: "developing-our-capacity-for-awareness",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "3e81ca09-9a81-4626-af3b-e33bf72d7eaa",
      type: "audio_file", specific_type: "mp3",
      description: "Day 4",
      display_name: "Embracing Calmness",
      number: 4,
      premium: true,
      b2_file_name: "tdmp-ep-01-embracing-calmness.mp3",
      slug: "embracing-calmness",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "a206a07e-3c1d-4ba6-9162-08c3887a8bb3",
      type: "audio_file", specific_type: "mp3",
      description: "Day 5",
      display_name: "Observe What You See",
      number: 5,
      premium: true,
      b2_file_name: "tdmp-ep-01-observe-what-you-see.mp3",
      slug: "observe-what-you-see",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "ad833bb5-6754-4bd0-8434-4ab4bea90ac8",
      type: "audio_file", specific_type: "mp3",
      description: "Day 6",
      display_name: "Observe What You Hear",
      number: 6,
      premium: true,
      b2_file_name: "tdmp-ep-01-observe-what-you-hear.mp3",
      slug: "observe-what-you-hear",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "7b455f3c-95be-4059-b854-29bb12387c0a",
      type: "audio_file", specific_type: "mp3",
      description: "Day 7",
      display_name: "Observe What You Touch",
      number: 7,
      premium: true,
      b2_file_name: "tdmp-ep-01-observe-what-you-touch.mp3",
      slug: "observe-what-you-touch",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "34393ebd-f7fe-48b8-b1db-c39858c22710",
      type: "audio_file", specific_type: "mp3",
      description: "Day 8",
      display_name: "Feeling Empowered",
      number: 8,
      premium: true,
      b2_file_name: "tdmp-ep-01-feeling-empowered.mp3",
      slug: "feeling-empowered",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "dd14c99f-7e08-4da6-ba59-011bc8c456ae",
      type: "audio_file", specific_type: "mp3",
      description: "Day 9",
      display_name: "Acknowledgement",
      number: 9,
      premium: true,
      b2_file_name: "tdmp-ep-01-acknowledgement.mp3",
      slug: "acknowledgement",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "9b9bcbd6-cceb-43fd-be8c-a671402941b5",
      type: "audio_file", specific_type: "mp3",
      description: "Day 10",
      display_name: "Acceptance",
      number: 10,
      premium: true,
      b2_file_name: "tdmp-ep-01-acceptance.mp3",
      slug: "acceptance",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "9d3fe0e5-50bd-4a91-a450-6ca66812d713",
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
