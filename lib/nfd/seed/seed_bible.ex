defmodule Nfd.SeedEBOOKS do
  alias Nfd.Repo
  # import Ecto

  alias Nfd.Content
  alias Nfd.Content.File
  alias Nfd.Content.Collection

  def seed do
    case Content.get_collection_seed_id("7a65219a-a965-460c-9a94-fcd5b74627be") do
      nil ->
        collection = Repo.insert!(%Collection{
          seed_id: "7a65219a-a965-460c-9a94-fcd5b74627be",
          type: "ebook_collection",
          active_type: "ebook_active_type",
          frequency: "NA",
          total_period: 0,
          status: "complete",
          stripe_sku: "NA",
          stripe_description: "The NeverFap Deluxe Bible is a complete collection of the NeverFap Deluxe Method of overcoming porn addiction.",
          subscribed_property_string: "",
          benefit_list: "Complete Website Collection",
          description: "The NeverFap Deluxe Bible is a complete collection of the NeverFap Deluxe Method of overcoming porn addiction.",
          display_name: "The NeverFap Deluxe Bible",
          cover_image: "/images/ebook_covers/bible-ebook-cover-600-900.png",
          premium: true,
          price: 12.99,
          slug: "neverfap-deluxe-bible"
        })

        bible_files(collection.id)
      _collection -> nil
    end
  end

  def bible_files(collection_id) do
    # TODO Spec this out with the proper files
    Repo.insert(%File{
      seed_id: "d0a9a1d2-fead-466b-94f3-5bea5d84a75a",
      type: "ebook_file",
      specific_type: "epub",
      description: "epub",
      display_name: "The NeverFap Deluxe Bible epub",
      bucket_name: "bible",
      file_url: "", 
      number: 666, # TODO
      premium: true,
      slug: "seven-day-neverfap-deluxe-kickstarter-epub",
      collection_id: collection_id
    })
  end
end
