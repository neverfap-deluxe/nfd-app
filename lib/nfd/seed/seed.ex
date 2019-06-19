defmodule Mix.Tasks.Nfd.Seed do  
  use Mix.Task
  alias Nfd.Repo

  alias Nfd.SeedSevenDayKickstarter

  alias Nfd.Repo
  alias Nfd.Account
  alias Nfd.Content
  alias Nfd.Content.File
  alias Nfd.Content.Collection
  
  alias Nfd.Account.User
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
    {:ok, dt_struct, _utc_offset} = DateTime.from_iso8601(date_string)
    
    user_k = Repo.insert!(User.changeset(%User{}, %{email: "k@k.com", password: "hellothere", confirm_password: "hellothere"}))
    Account.update_user_email_confirm(user_k, %{ email_confirmed_at: DateTime.truncate(dt_struct, :second) })
    
    Repo.insert!(User.changeset(%User{}, %{email: "u@u.com", password: "hellothere", confirm_password: "hellothere"}))
  end

  def seed_collections() do
    case Content.get_collection_seed_id("068b52c1-cce1-4239-a345-1182ae528a41") do
      nil -> 
        Repo.insert!(%Collection{
          seed_id: "068b52c1-cce1-4239-a345-1182ae528a41",
          type: "email_campaign",
          status: "complete",
          stripe_sku: "NA",
          stripe_description: "Kickstart your NeverFap Deluxe journey with our seven day course which will take you through everything you need to know about overcoming your porn addiction.",
          description: "Kickstart your NeverFap Deluxe journey with our seven day course which will take you through everything you need to know about overcoming your porn addiction.",
          display_name: "7 Day NeverFap Deluxe Kickstarter",
          premium: false,
          price: 0.0,
          slug: "seven-day-neverfap-deluxe-kickstarter"
        })

      _collection -> nil
    end
      
    case Content.get_collection_seed_id("943bd030-60e4-42da-a8c1-0c926c508374") do
      nil -> 
        Repo.insert!(%Collection{
          seed_id: "943bd030-60e4-42da-a8c1-0c926c508374",
          type: "email_campaign",
          status: "complete",
          stripe_sku: "NA",
          stripe_description: "10 Day Meditation Primer Audio Series.",
          description: "Want to learn more about meditation and best practices? The 10 day meditation primer is an excellent place to start.",
          display_name: "10 Day Meditation Primer",
          premium: true,
          price: 9.99,
          slug: "ten-day-meditation-primer"
        })
        Repo.insert(%File{
          seed_id: "dd5b4c6f-b8b1-4a2e-b30d-4bd7f081f9d2",
          type: "audio",
          description: "10 Day Meditation Primer - Day 1",
          display_name: "Expressing Gratitude",
          file_url: "", # TODO
          premium: true,
          slug: "expressing-gratitude"
        })
        Repo.insert(%File{
          seed_id: "2ce626da-3930-4d2d-b394-3a8e52dd1f73",
          type: "audio",
          description: "10 Day Meditation Primer - Day 2",
          display_name: "Focus On Your Finger And Your Background",
          file_url: "", # TODO
          premium: true,
          slug: "focus-on-your-finger-and-your-background"
        })
        Repo.insert(%File{
          seed_id: "aa792de7-e471-4d82-9215-dc73aeb94689",
          type: "audio",
          description: "10 Day Meditation Primer - Day 3",
          display_name: "Relax Everything",
          file_url: "", # TODO
          premium: true,
          slug: "relax-everything"
        })
        Repo.insert(%File{
          seed_id: "af235f37-b0c4-4bc9-a171-9f71788b106c",
          type: "audio",
          description: "10 Day Meditation Primer - Day 4",
          display_name: "Slow Down Time",
          file_url: "", # TODO
          premium: true,
          slug: "slow-down-time"
        })
        Repo.insert(%File{
          seed_id: "969f1b8d-1cfb-4112-a926-7a52eb4907db",
          type: "audio",
          description: "10 Day Meditation Primer - Day 5",
          display_name: "Identify Points Of Awareness Throughout The Day",
          file_url: "", # TODO
          premium: true,
          slug: "identify-points-of-awareness-throughout-your-day"
        })
        Repo.insert(%File{
          seed_id: "969f1b8d-1cfb-4112-a926-7a52eb4907db",
          type: "audio",
          description: "10 Day Meditation Primer - Day 6",
          display_name: "Identify Points Of Awareness Throughout The Day",
          file_url: "", # TODO
          premium: true,
          slug: "identify-points-of-awareness-throughout-your-day"
        })

        

Can You Look Through Walls?
Looking Straight Ahead


      _collection -> nil
    end
    
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
  end
end  
