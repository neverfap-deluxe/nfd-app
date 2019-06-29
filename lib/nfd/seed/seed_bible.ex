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
          course_config_type: "NA",
          frequency: "NA",
          total_period: 0,
          status: "in_progress",
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
    Repo.insert(%File{
      seed_id: "05aa9e4a-e346-4dfb-985b-b3035af59401",
      type: "ebook_file",
      specific_type: "epub",
      description: "",
      display_name: "The NeverFap Deluxe Bible epub",
      b2_file_name: "neverfap-deluxe-bible.epub",
      number: -666,
      premium: false,
      slug: "neverfap-deluxe-bible-epub",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "7e93dff4-27e5-4642-9fef-4347ee68d588",
      type: "ebook_file",
      specific_type: "pdf",
      description: "",
      display_name: "The NeverFap Deluxe Bible pdf",
      b2_file_name: "neverfap-deluxe-bible.pdf",
      number: -666,
      premium: false,
      slug: "neverfap-deluxe-bible-pdf",
      collection_id: collection_id
    })
  end
end
