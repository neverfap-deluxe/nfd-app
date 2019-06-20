defmodule Nfd.SeedUsers do
  alias Nfd.Repo
  # import Ecto


  alias Nfd.Account
  alias Nfd.Account.User

  def seed do
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
end
