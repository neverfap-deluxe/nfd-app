# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Nfd.Repo.insert!(%Nfd.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Nfd.Repo

# alias Nfd.Account.User
# alias Nfd.Account.Subscriber
# alias Nfd.Account.CollectionAccess

alias Nfd.Content.Collection
alias Nfd.Content.File

# Repo.delete_all(User)    
# Repo.delete_all(Subscriber)    
# Repo.delete_all(CollectionAccess)    

Repo.delete_all(Collection)    
Repo.delete_all(File)    

Repo.insert!(%Collection{
  type: "email_campaign",
  status: "",
  description: "",
  display_name: "7 Day NeverFap Deluxe Kickstarter",
  premium: false,
  slug: "seven-day-neverfap-deluxe-kickstarter"
})

Repo.insert!(%Collection{
  type: "email_campaign",
  status: "",
  description: "",
  display_name: "10 Day Meditation Primer",
  premium: false,
  slug: "ten-day-meditation-primer",
})

Repo.insert!(%Collection{
  type: "email_campaign",
  status: "",
  description: "",
  display_name: "28 Day Awareness Challenge",
  premium: false,
  slug: "twenty-eight-day-awareness-challenge",
})