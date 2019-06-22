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
          status: "complete",
          stripe_sku: "NA",
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
      type: "audio_file",
      description: "Day 1",
      display_name: "Meditation Basics",
      bucket_name: "tdmp",
      file_url: "", # TODO
      premium: true,
      slug: "meditation-basics",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "8aa47f35-ee3a-47e9-938c-48f61f24a893",
      type: "audio_file",
      description: "Day 2",
      display_name: "Understanding The Purpose Of Meditation",
      bucket_name: "tdmp",
      file_url: "", # TODO
      premium: true,
      slug: "understanding-the-purpose-of-meditation",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "ef587626-1c38-48a9-9128-567585bea7a6",
      type: "audio_file",
      description: "Day 3",
      display_name: "Developing Our Capacity For Awareness",
      bucket_name: "tdmp",
      file_url: "", # TODO
      premium: true,
      slug: "developing-our-capacity-for-awareness",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "3e81ca09-9a81-4626-af3b-e33bf72d7eaa",
      type: "audio_file",
      description: "Day 4",
      display_name: "Embracing Calmness",
      bucket_name: "tdmp",
      file_url: "", # TODO
      premium: true,
      slug: "embracing-calmness",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "a206a07e-3c1d-4ba6-9162-08c3887a8bb3",
      type: "audio_file",
      description: "Day 5",
      display_name: "Observe What You See",
      bucket_name: "tdmp",
      file_url: "", # TODO
      premium: true,
      slug: "observe-what-you-see",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "ad833bb5-6754-4bd0-8434-4ab4bea90ac8",
      type: "audio_file",
      description: "Day 6",
      display_name: "Observe What You Hear",
      bucket_name: "tdmp",
      file_url: "", # TODO
      premium: true,
      slug: "observe-what-you-hear",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "7b455f3c-95be-4059-b854-29bb12387c0a",
      type: "audio_file",
      description: "Day 7",
      display_name: "Observe What You Feel",
      bucket_name: "tdmp",
      file_url: "", # TODO
      premium: true,
      slug: "observe-what-you-feel",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "34393ebd-f7fe-48b8-b1db-c39858c22710",
      type: "audio_file",
      description: "Day 8",
      display_name: "Feeling Empowered",
      bucket_name: "tdmp",
      file_url: "", # TODO
      premium: true,
      slug: "feeling-empowered",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "dd14c99f-7e08-4da6-ba59-011bc8c456ae",
      type: "audio_file",
      description: "Day 9",
      display_name: "Acknowledgement",
      bucket_name: "tdmp",
      file_url: "", # TODO
      premium: true,
      slug: "acknowledgement",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "9b9bcbd6-cceb-43fd-be8c-a671402941b5",
      type: "audio_file",
      description: "Day 10",
      display_name: "Acceptance",
      bucket_name: "tdmp",
      file_url: "", # TODO
      premium: true,
      slug: "acceptance",
      collection_id: collection_id
    })
  end

end
