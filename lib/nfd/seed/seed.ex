defmodule Mix.Tasks.Nfd.Seed do
  use Mix.Task
  alias Nfd.Repo

  alias Nfd.Repo
  alias Nfd.Account
  alias Nfd.Content
  alias Nfd.Content.File
  alias Nfd.Content.Collection

  # alias Nfd.Account.Subscriber
  # alias Nfd.Account.CollectionAccess

  def run(_) do
    Mix.Task.run "app.start", []
    seed(Mix.env)
  end

  def seed(:dev) do
    Repo.delete_all(Collection)
    Repo.delete_all(File)

    seed_users()
    seed_collections()
  end

  def seed(:prod) do
    Repo.delete_all(Collection)
    Repo.delete_all(File)

    seed_collections()
  end

  def seed_users do
    Nfd.SeedUsers.seed()
  end


  # 7 Day NeverFap Deluxe Kickstarter
  def seed_collections() do
    Nfd.SeedSDK.seed()
    Nfd.SeedTDMP.seed()
    Nfd.SeedSWAVOL1.seed()
    Nfd.SeedSWAVOL2.seed()
    Nfd.SeedSWAVOL3.seed()
    Nfd.SeedSWAVOL4.seed()
  end
end



# 28 Day Awareness
# case Content.get_collection_seed_id("12ec4d76-3d93-42c5-8c2f-65bb146e4bd6") do
#   nil ->
#     Repo.insert!(%Collection{
#     seed_id: "12ec4d76-3d93-42c5-8c2f-65bb146e4bd6",
#     type: "email_campaign",
#     status: "in_progress",
#     stripe_sku: "NA",
#     stripe_description: "Learn more about your awareness with our 28 day awareness challenge.",
#     description: "Learn more about your awareness with our 28 day awareness challenge.",
#     display_name: "28 Day Awareness Challenge",
#     premium: true,
#     price: 14.99,
#     slug: "twenty-eight-day-awareness-challenge"
#   })

#   _collection -> nil
# end
