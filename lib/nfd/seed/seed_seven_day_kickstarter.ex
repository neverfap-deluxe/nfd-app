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
          frequency: "day",
          total_period: 7,
          status: "complete",
          stripe_sku: "NA",
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
      seven_day_kickstarter_files(collection.id)

      _collection -> nil
    end
  end

  def seven_day_kickstarter_files(collection_id) do
    : Add in the email/day files.

    Repo.insert(%File{
      seed_id: "a78835ce-5d49-4107-b57c-ef094b0efb7b",
      type: "ebook_file",
      description: "epub",
      display_name: "7 Day NeverFap Deluxe Kickstarter epub",
      bucket_name: "sdk",
      file_url: "", 
      premium: true,
      slug: "seven-day-neverfap-deluxe-kickstarter-ebook",
      collection_id: collection_id
    })
    # Repo.insert(%File{
    #   seed_id: "78d44e56-12e6-4faf-b65e-ddbdd5ac5325",
    #   type: "email_file",
    #   description: "Day 0",
    #   display_name: "The Introduction",
    #   bucket_name: "swavol3",
    #   file_url: "", 
    #   premium: true,
    #   slug: "introduction",
    #   collection_id: collection_id
    # })
    # Repo.insert(%File{
    #   seed_id: "2c8bb2ba-9349-40be-8e66-195954945159",
    #   type: "email_file",
    #   description: "Day 1",
    #   display_name: "The Trust",
    #   bucket_name: "swavol3",
    #   file_url: "", 
    #   premium: true,
    #   slug: "introduction",
    #   collection_id: collection_id
    # })
    # Repo.insert(%File{
    #   seed_id: "6d8f41fd-0b63-469e-a765-351465e4aa6b",
    #   type: "email_file",
    #   description: "Day 2",
    #   display_name: "Just Do, Don't Think",
    #   bucket_name: "swavol3",
    #   file_url: "", 
    #   premium: true,
    #   slug: "just-do-dont-think",
    #   collection_id: collection_id
    # })
    # Repo.insert(%File{
    #   seed_id: "1cd186ac-f960-4be2-a749-a78b16f0c4ed",
    #   type: "email_file",
    #   description: "Day 3",
    #   display_name: "Fighting Spirit",
    #   bucket_name: "swavol3",
    #   file_url: "", 
    #   premium: true,
    #   slug: "fighting-spirit",
    #   collection_id: collection_id
    # })
    # Repo.insert(%File{
    #   seed_id: "e01f00d7-9fc8-4973-8e06-9a4a1641ef54",
    #   type: "email_file",
    #   description: "Day 4",
    #   display_name: "Every 30 Minutes",
    #   bucket_name: "swavol3",
    #   file_url: "", 
    #   premium: true,
    #   slug: "every-30-minutes",
    #   collection_id: collection_id
    # })
    # Repo.insert(%File{
    #   seed_id: "f9c17788-3581-45a1-a20b-1b1e28f7e1f3",
    #   type: "email_file",
    #   description: "Day 5",
    #   display_name: "Control The Intonation Of Your Breath",
    #   bucket_name: "swavol3",
    #   file_url: "", 
    #   premium: true,
    #   slug: "control-the-intonation-of-your-breath",
    #   collection_id: collection_id
    # })
    # Repo.insert(%File{
    #   seed_id: "305e3cf3-8b86-41e3-863a-93c6168a8539",
    #   type: "email_file",
    #   description: "Day 6",
    #   display_name: "Catching The Odd Judge Out",
    #   bucket_name: "swavol3",
    #   file_url: "", 
    #   premium: true,
    #   slug: "catching-the-odd-judge-out",
    #   collection_id: collection_id
    # })
    # Repo.insert(%File{
    #   seed_id: "d64f3f7d-c528-4d36-aa5a-3a0962772bda",
    #   type: "email_file",
    #   description: "Day 7",
    #   display_name: "Focus Your Attention",
    #   bucket_name: "swavol3",
    #   file_url: "", 
    #   premium: true,
    #   slug: "focus-your-attention",
    #   collection_id: collection_id
    # })

  end
end
