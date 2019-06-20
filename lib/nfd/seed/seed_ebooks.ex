defmodule Nfd.SeedEBOOKS do
  alias Nfd.Repo
  # import Ecto

  alias Nfd.Content
  alias Nfd.Content.File
  alias Nfd.Content.Collection

  def seed do
    case Content.get_collection_seed_id("7a65219a-a965-460c-9a94-fcd5b74627be") do
      nil ->
        Repo.insert!(%Collection{
          seed_id: "7a65219a-a965-460c-9a94-fcd5b74627be",
          type: "ebook",
          status: "complete",
          stripe_sku: "NA",
          stripe_description: "The NeverFap Deluxe Bible is a complete collection of the NeverFap Deluxe Method of overcoming porn addiction.",
          description: "The NeverFap Deluxe Bible is a complete collection of the NeverFap Deluxe Method of overcoming porn addiction.",
          display_name: "The NeverFap Deluxe Bible",
          premium: true,
          price: 12.99,
          slug: "the-neverfap-deluxe-bible"
        })

      _collection -> nil
    end
  end
end
