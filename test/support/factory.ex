defmodule Nfd.Factory do
  # with Ecto
  use ExMachina.Ecto, repo: Nfd.Repo

  # without Ecto
  use ExMachina

  def user_factory do
    %Nfd.User{
      display_name: "Jane Smith",
      email: sequence(:email, &"email-#{&1}@gmail.com"),
    }
  end

  def user_with_subscriber_factory do
    %Nfd.User{
      display_name: "Jane Smith",
      email: sequence(:email, &"email-#{&1}@gmail.com"),
      subscriber: build(:subscriber)
    }
  end

  def subscriber_factory do
    %Nfd.User{
      subscriber_email: sequence(:email, &"email-#{&1}@gmail.com"),
    }
  end

  def subscriber_with_user_factory do
    %Nfd.User{
      subscriber_email: sequence(:email, &"email-#{&1}@gmail.com"),
      user: build(:user)
    }
  end
end