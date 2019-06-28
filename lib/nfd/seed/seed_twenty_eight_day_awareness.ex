defmodule Nfd.SeedTEDA do
  alias Nfd.Repo
  # import Ecto

  alias Nfd.Content
  alias Nfd.Content.File
  alias Nfd.Content.Collection

  def seed do
  #   case Content.get_collection_seed_id("de3d7f8a-fda6-4b1a-ba50-31cc3181b4bd") do
  #     nil ->
  #       Repo.insert!(%Collection{
  #         seed_id: "de3d7f8a-fda6-4b1a-ba50-31cc3181b4bd",
  #         type: "course_collection",
  #         active_type: "awareness_active_type",
  #         course_config_type: "awarenesschallenge",
  #         frequency: "day",
  #         total_period: 28,
  #         status: "in_progress",
  #         stripe_description: "Learn more about your awareness with our 28 day awareness challenge.",
  #         benefit_list: "",
  #         subscribed_property_string: "twenty_eight_day_awareness_subscribed",
  #         description: "Learn more about your awareness with our 28 day awareness challenge.",
  #         display_name: "28 Day Awareness Challenge",
  #         cover_image: "/images/ebook_covers/na",
  #         premium: true,
  #         price: 14.99,
  #         slug: "twenty-eight-day-awareness-challenge"
  #       })

  #     _collection -> nil
  #   end
  end

end
