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
          type: "ebook_collection",
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
        Repo.insert(%File{
          seed_id: "a78835ce-5d49-4107-b57c-ef094b0efb7b",
          type: "ebook_file",
          description: "The ebook version of the 7 Day NeverFap Deluxe Kickstarter.",
          display_name: "7 Day NeverFap Deluxe Kickstarter ebook",
          bucket_name: "swavol1",
          file_url: "", # TODO
          premium: true,
          slug: "seven-day-neverfap-deluxe-kickstarter-ebook",
          collection_id: collection.id
        })

      _collection -> nil
    end
  end
end
