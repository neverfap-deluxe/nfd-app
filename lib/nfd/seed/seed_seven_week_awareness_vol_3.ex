defmodule Nfd.SeedSWAVOL3 do
  alias Nfd.Repo
  # import Ecto

  alias Nfd.Content
  alias Nfd.Content.File

  def seed do
    case Content.get_collection_seed_id("c014f1c5-be89-455f-8f88-970c6cf70d5d") do
      nil ->
        collection = Repo.insert!(%Collection{
          seed_id: "c014f1c5-be89-455f-8f88-970c6cf70d5d",
          type: "course",
          status: "in_progress",
          stripe_sku: "NA",
          stripe_description: "Learn more about your awareness with Vol 3. of our 7 week awareness challenge.",
          description: "Learn more about your awareness with Vol 3. of our 7 week awareness challenge.",
          display_name: "7 Week Awareness Challenge Vol 3.",
          premium: true,
          price: 14.99,
          slug: "seven-week-awareness-challenge-vol-3"
        })
        seven_week_awareness_vol_3_files(collection.id)

      _collection -> nil
    end
  end

  def seven_week_awareness_vol_3_files(collection_id) do
    Repo.insert(%File{
      seed_id: "9538ad08-ce36-4513-a150-2c9bf7e791a7",
      type: "audio",
      description: "7 Week Awareness Challenge Vol 3 - Week 1",
      display_name: "Where Do You Touch?",
      bucket_name: "swavol3",
      file_url: "", # TODO
      premium: true,
      slug: "where-do-you-touch",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "3bf3527c-3cf8-4939-bf80-82b9b87f80cf",
      type: "audio",
      description: "7 Week Awareness Challenge Vol 3 - Week 2",
      display_name: "Use Your Opposite Hand",
      bucket_name: "swavol3",
      file_url: "", # TODO
      premium: true,
      slug: "use-your-opposite-hand",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "1e3c3c70-6f2c-4b77-8c5c-2212ccbdc892",
      type: "audio",
      description: "7 Week Awareness Challenge Vol 3 - Week 3",
      display_name: "Who Is Looking?",
      bucket_name: "swavol3",
      file_url: "", # TODO
      premium: true,
      slug: "who-is-looking",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "b34ecae6-ae6c-440f-831c-f035f4f33ab5",
      type: "audio",
      description: "7 Week Awareness Challenge Vol 3 - Week 4",
      display_name: "Identifying The Feeling Of Obligation",
      bucket_name: "swavol3",
      file_url: "", # TODO
      premium: true,
      slug: "identifying-the-feeling-of-obligation",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "95e53cea-95b8-4a28-9458-f33f4f127eb5",
      type: "audio",
      description: "7 Week Awareness Challenge Vol 3 - Week 5",
      display_name: "Engaging Expression",
      bucket_name: "swavol3",
      file_url: "", # TODO
      premium: true,
      slug: "engaging-expression",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "3d7a52d7-dbb2-4e5f-a483-7268c36e7823",
      type: "audio",
      description: "7 Week Awareness Challenge Vol 3 - Week 6",
      display_name: "Object Attachment",
      bucket_name: "swavol3",
      file_url: "", # TODO
      premium: true,
      slug: "object-attachment",
      collection_id: collection_id
    })
    Repo.insert(%File{
      seed_id: "29c38a9f-4b45-434b-9879-7bed344216b6",
      type: "audio",
      description: "7 Week Awareness Challenge Vol 3 - Week 7",
      display_name: "Slow Spinning Circle",
      bucket_name: "swavol3",
      file_url: "", # TODO
      premium: true,
      slug: "slow-spinning-circle",
      collection_id: collection_id
    })
  end
end
