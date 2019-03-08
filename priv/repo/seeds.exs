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
alias Nfd.Account

alias Nfd.Account.User
alias Nfd.Account.Subscriber
# alias Nfd.Account.CollectionAccess

alias Nfd.Content.Collection
alias Nfd.Content.File

# Repo.delete_all(User)    
# Repo.delete_all(Subscriber)    
# Repo.delete_all(CollectionAccess)    

Repo.delete_all(Collection)    
Repo.delete_all(File)    

# Confirmed user
user_one = Account.get_user_email("k@k.com")
if user_one, do: Account.delete_user(user_one)

# Unconfirmed user
user_two = Account.get_user_email("u@u.com")
if user_two, do: Account.delete_user(user_two)

date_string = "2018-12-30T16:00:00.000Z"             
{:ok, dt_struct, utc_offset} = DateTime.from_iso8601(date_string)

user_k = Repo.insert!(User.changeset(%User{}, %{
  email: "k@k.com",
  password: "hellothere",
  confirm_password: "hellothere"
  # subscriber: %{
  #   subscriber_email: "k@k.com"
  # }
}))

Account.update_user_email_confirm(user_k, %{ email_confirmed_at: DateTime.truncate(dt_struct, :second) })

user_u = Repo.insert!(User.changeset(%User{}, %{
  email: "u@u.com",
  password: "hellothere",
  confirm_password: "hellothere"
  # subscriber: %{
  #   subscriber_email: "u@u.com"
  # }
}))


# # Collections

# Repo.insert!(%Collection{
#   type: "email_campaign",
#   status: "in_progress",
#   description: "Kickstart your NeverFap Deluxe journey with our seven day course which will take you through everything you need to know about overcoming your porn addiction.",
#   display_name: "7 Day NeverFap Deluxe Kickstarter",
#   premium: false,
#   price: 0.0,
#   slug: "seven-day-neverfap-deluxe-kickstarter"
# })

# Repo.insert!(%Collection{
#   type: "email_campaign",
#   status: "in_progress",
#   description: "Want to learn more about meditation and best practices? The 10 day meditation primer is an excellent place to start.",
#   display_name: "10 Day Meditation Primer",
#   premium: false,
#   price: 9.99,
#   slug: "ten-day-meditation-primer",
# })

# Repo.insert!(%Collection{
#   type: "email_campaign",
#   status: "in_progress",
#   description: "",
#   display_name: "28 Day Awareness Challenge",
#   premium: false,
#   price: 14.99,
#   slug: "twenty-eight-day-awareness-challenge",
# })


