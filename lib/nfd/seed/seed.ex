defmodule Mix.Tasks.Nfd.Seed do  
  use Mix.Task
  alias Nfd.Repo
  import Ecto

  alias Nfd.SeedSevenDayKickstarter

  alias Nfd.Repo
  alias Nfd.Account
  alias Nfd.Content
  
  alias Nfd.Account.User
  # alias Nfd.Account.Subscriber
  # alias Nfd.Account.CollectionAccess
  
  alias Nfd.Content.Collection
  alias Nfd.Content.File
  
  def run(_) do
    Mix.Task.run "app.start", []
    seed(Mix.env)
  end

  def seed(:dev) do    
    seed_users()
    seed_collections()
    SeedSevenDayKickstarter.seed()
  end

  def seed(:prod) do
    seed_collections()
    SeedSevenDayKickstarter.seed()
  end

  def seed_users() do 
    # Confirmed user
    case Account.get_user_email("k@k.com") do
      nil -> 
        nil
      user_one -> 
        IO.inspect user_one
        Account.delete_user(user_one)
    end
    
    # Unconfirmed user
    case Account.get_user_email("u@u.com") do
      nil -> nil
      user_two -> Account.delete_user(user_two)
    end

    date_string = "2018-12-30T16:00:00.000Z"             
    {:ok, dt_struct, utc_offset} = DateTime.from_iso8601(date_string)
    
    user_k = Repo.insert!(User.changeset(%User{}, %{email: "k@k.com", password: "hellothere", confirm_password: "hellothere"}))
    Account.update_user_email_confirm(user_k, %{ email_confirmed_at: DateTime.truncate(dt_struct, :second) })
    
    user_u = Repo.insert!(User.changeset(%User{}, %{email: "u@u.com", password: "hellothere", confirm_password: "hellothere"}))
  end

  def seed_collections() do
    case Content.get_collection_seed_id("068b52c1-cce1-4239-a345-1182ae528a41") do
      nil -> Repo.insert!(%Collection{
          seed_id: "068b52c1-cce1-4239-a345-1182ae528a41",
          type: "email_campaign",
          status: "in_progress",
          description: "Kickstart your NeverFap Deluxe journey with our seven day course which will take you through everything you need to know about overcoming your porn addiction.",
          display_name: "7 Day NeverFap Deluxe Kickstarter",
          premium: false,
          price: 0.0,
          slug: "seven-day-neverfap-deluxe-kickstarter"
        })

      collection -> nil
    end
      
    case Content.get_collection_seed_id("943bd030-60e4-42da-a8c1-0c926c508374") do
      nil -> Repo.insert!(%Collection{
          seed_id: "943bd030-60e4-42da-a8c1-0c926c508374",
          type: "email_campaign",
          status: "in_progress",
          description: "Want to learn more about meditation and best practices? The 10 day meditation primer is an excellent place to start.",
          display_name: "10 Day Meditation Primer",
          premium: false,
          price: 9.99,
          slug: "ten-day-meditation-primer"
        })

      collection -> nil
    end
    
    case Content.get_collection_seed_id("12ec4d76-3d93-42c5-8c2f-65bb146e4bd6") do
      nil -> Repo.insert!(%Collection{
        seed_id: "12ec4d76-3d93-42c5-8c2f-65bb146e4bd6",
        type: "email_campaign",
        status: "in_progress",
        description: "Learn more about your awareness with our 28 day awareness challenge.",
        display_name: "28 Day Awareness Challenge",
        premium: false,
        price: 14.99,
        slug: "twenty-eight-day-awareness-challenge"
      })

      collection -> nil
    end
  end
end  
