defmodule Nfd.SeedSevenDayKickstarter do
  alias Nfd.Repo
  import Ecto

  alias Nfd.Content
  alias Nfd.Content.File

  def seed do
    file = %{
      type: "email",
      premium: false,
    }

    # Seven Day kickstarter
    case Content.get_collection_seed_id("068b52c1-cce1-4239-a345-1182ae528a41") do
      nil -> nil
      collection ->
        # day 0
        case Content.get_file_seed_id("8710f97c-4117-431d-99c8-4c734d916276") do
          nil -> Repo.insert!(File.changeset_with_collection(
            %File{},
            Map.merge(%{
              seed_id: "8710f97c-4117-431d-99c8-4c734d916276",
              file_url: "", # There is no file.
              display_name: "Day 0 - The Beginning",
              description: "Learn about the beginning.",
              slug: "day-0",
              collection_id: collection.id
              },
              file)
            )
          )
          _collection -> nil
        end

        # day 1
        case Content.get_file_seed_id("2279faec-a1fb-4d42-a140-f8946aae9e9e") do
          nil -> Repo.insert!(File.changeset_with_collection(
            %File{},
            Map.merge(%{
              seed_id: "2279faec-a1fb-4d42-a140-f8946aae9e9e",
              file_url: "", # There is no file.
              display_name: "Day 1 - The Awareness",
              description: "Yeah",
              slug: "day-1",
              collection_id: collection.id
              },
              file)
            )
          )
          _collection -> nil
        end
        
    end
  end

end