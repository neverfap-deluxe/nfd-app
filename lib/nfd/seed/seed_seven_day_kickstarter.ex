defmodule Nfd.SeedSDK do
  alias Nfd.Repo
  # import Ecto

  alias Nfd.Content
  alias Nfd.Content.File
  alias Nfd.Content.Collection

  def seed do
    case Content.get_collection_seed_id("068b52c1-cce1-4239-a345-1182ae528a41") do
      nil ->
        collection = Repo.insert!(%Collection{
          seed_id: "068b52c1-cce1-4239-a345-1182ae528a41",
          type: "course_collection",
          active_type: "free_active_type",
          course_config_type: "neverfapdeluxekickstarter",
          frequency: "day",
          total_period: 7,
          status: "complete",
          stripe_description: "Kickstart your NeverFap Deluxe journey with our seven day course which will take you through everything you need to know about overcoming your porn addiction.",
          benefit_list: "Written Guide Explaining NeverFap Deluxe;Delivered Over 7 Days via Email",
          subscribed_property_string: "seven_day_kickstarter_subscribed",
          description: "Kickstart your NeverFap Deluxe journey with our seven day course which will take you through everything you need to know about overcoming your porn addiction.",
          display_name: "7 Day NeverFap Deluxe Kickstarter",
          cover_image: "/images/ebook_covers/7-day-kickstarter-ebook-cover-600-900.png",
          premium: false,
          price: 0.0,
          slug: "seven-day-neverfap-deluxe-kickstarter"
        })
        seven_day_kickstarter_audio_files(collection.id)
        seven_day_kickstarter_ebook_files(collection.id)

      _collection -> nil
    end
  end

  def seven_day_kickstarter_ebook_files(collection_id) do
    Repo.insert(%File{
      seed_id: "17753806-53b8-4cbb-80e2-6dac28992939",
      type: "ebook_file",
      specific_type: "epub",
      description: "",
      display_name: "7 Day NeverFap Deluxe Kickstarter epub",
      b2_file_name: "neverfap-deluxe-seven-day-kickstarter.epub",
      number: -666,
      premium: false,
      slug: "seven-day-neverfap-deluxe-kickstarter-epub",
      collection_id: collection_id
    })
    # Repo.insert(%File{
    #   seed_id: "40a6509c-b948-40bd-9ecc-d2f2736a8ec4",
    #   type: "ebook_file",
    #   specific_type: "pdf",
    #   description: "",
    #   display_name: "7 Day NeverFap Deluxe Kickstarter pdf",
    #   b2_file_name: "neverfap-deluxe-seven-day-kickstarter.pdf",
    #   number: -666,
    #   premium: false,
    #   slug: "seven-day-neverfap-deluxe-kickstarter-pdf",
    #   collection_id: collection_id
    # })
  end

  def seven_day_kickstarter_audio_files(collection_id) do
    Repo.insert(%File{
      seed_id: "78d44e56-12e6-4faf-b65e-ddbdd5ac5325",
      type: "email_file",
      specific_type: "email",
      description: "Day 0",
      display_name: "The Introduction",
      number: 0,
      premium: false,
      b2_file_name: "",
      slug: "introduction",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "2c8bb2ba-9349-40be-8e66-195954945159",
      type: "email_file",
      specific_type: "email",
      description: "Day 1",
      display_name: "The Trust",
      number: 1,
      premium: false,
      b2_file_name: "",
      slug: "the-trust",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "6d8f41fd-0b63-469e-a765-351465e4aa6b",
      type: "email_file",
      specific_type: "email",
      description: "Day 2",
      display_name: "The Awareness",
      number: 2,
      premium: false,
      b2_file_name: "",
      slug: "the-awareness",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "1cd186ac-f960-4be2-a749-a78b16f0c4ed",
      type: "email_file",
      specific_type: "email",
      description: "Day 3",
      display_name: "The Calmness",
      number: 3,
      premium: false,
      b2_file_name: "",
      slug: "the-calmness",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "e01f00d7-9fc8-4973-8e06-9a4a1641ef54",
      type: "email_file",
      specific_type: "email",
      description: "Day 4",
      display_name: "The Meditation",
      number: 4,
      premium: false,
      b2_file_name: "",
      slug: "the-meditation",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "f9c17788-3581-45a1-a20b-1b1e28f7e1f3",
      type: "email_file",
      specific_type: "email",
      description: "Day 5",
      display_name: "The Relapse",
      number: 5,
      premium: false,
      b2_file_name: "",
      slug: "the-relapse",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "305e3cf3-8b86-41e3-863a-93c6168a8539",
      type: "email_file",
      specific_type: "email",
      description: "Day 6",
      display_name: "The Consistency",
      number: 6,
      premium: false,
      b2_file_name: "",
      slug: "the-consistency",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "d64f3f7d-c528-4d36-aa5a-3a0962772bda",
      type: "email_file",
      specific_type: "email",
      description: "Day 7",
      display_name: "The Community",
      number: 7,
      premium: false,
      b2_file_name: "",
      slug: "the-community",
      collection_id: collection_id
    })
  end
end
