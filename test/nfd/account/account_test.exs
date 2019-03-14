defmodule Nfd.AccountTest do
  use Nfd.DataCase

  alias Nfd.Account

  describe "users" do
    alias Nfd.Account.User

    @valid_attrs %{coaching_minutes: 42, display_name: "some display_name", first_name: "some first_name", is_admin: true, last_name: "some last_name", slug: "some slug"}
    @update_attrs %{coaching_minutes: 43, display_name: "some updated display_name", first_name: "some updated first_name", is_admin: false, last_name: "some updated last_name", slug: "some updated slug"}
    @invalid_attrs %{coaching_minutes: nil, display_name: nil, first_name: nil, is_admin: nil, last_name: nil, slug: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Account.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Account.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Account.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Account.create_user(@valid_attrs)
      assert user.coaching_minutes == 42
      assert user.display_name == "some display_name"
      assert user.first_name == "some first_name"
      assert user.is_admin == true
      assert user.last_name == "some last_name"
      assert user.slug == "some slug"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Account.update_user(user, @update_attrs)
      assert user.coaching_minutes == 43
      assert user.display_name == "some updated display_name"
      assert user.first_name == "some updated first_name"
      assert user.is_admin == false
      assert user.last_name == "some updated last_name"
      assert user.slug == "some updated slug"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Account.update_user(user, @invalid_attrs)
      assert user == Account.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Account.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Account.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Account.change_user(user)
    end
  end

  describe "collection_access" do
    alias Nfd.Account.CollectionAccess

    @valid_attrs %{collection_id: "some collection_id"}
    @update_attrs %{collection_id: "some updated collection_id"}
    @invalid_attrs %{collection_id: nil}

    def collection_access_fixture(attrs \\ %{}) do
      {:ok, collection_access} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Account.create_collection_access()

      collection_access
    end

    test "list_collection_access/0 returns all collection_access" do
      collection_access = collection_access_fixture()
      assert Account.list_collection_access() == [collection_access]
    end

    test "get_collection_access!/1 returns the collection_access with given id" do
      collection_access = collection_access_fixture()
      assert Account.get_collection_access!(collection_access.id) == collection_access
    end

    test "create_collection_access/1 with valid data creates a collection_access" do
      assert {:ok, %CollectionAccess{} = collection_access} = Account.create_collection_access(@valid_attrs)
      assert collection_access.collection_id == "some collection_id"
    end

    test "create_collection_access/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_collection_access(@invalid_attrs)
    end

    test "update_collection_access/2 with valid data updates the collection_access" do
      collection_access = collection_access_fixture()
      assert {:ok, %CollectionAccess{} = collection_access} = Account.update_collection_access(collection_access, @update_attrs)
      assert collection_access.collection_id == "some updated collection_id"
    end

    test "update_collection_access/2 with invalid data returns error changeset" do
      collection_access = collection_access_fixture()
      assert {:error, %Ecto.Changeset{}} = Account.update_collection_access(collection_access, @invalid_attrs)
      assert collection_access == Account.get_collection_access!(collection_access.id)
    end

    test "delete_collection_access/1 deletes the collection_access" do
      collection_access = collection_access_fixture()
      assert {:ok, %CollectionAccess{}} = Account.delete_collection_access(collection_access)
      assert_raise Ecto.NoResultsError, fn -> Account.get_collection_access!(collection_access.id) end
    end

    test "change_collection_access/1 returns a collection_access changeset" do
      collection_access = collection_access_fixture()
      assert %Ecto.Changeset{} = Account.change_collection_access(collection_access)
    end
  end

  describe "subscribers" do
    alias Nfd.Account.Subscriber

    @valid_attrs %{seven_day_kickstarter_count: 42, seven_day_kickstarter_subscribed: true, subscribed: true, subscriber_email: "some subscriber_email", ten_day_meditation_count: 42, ten_day_meditation_subscribed: true, twenty_eight_day_awareness_count: 42, twenty_eight_day_awareness_subscribed: true}
    @update_attrs %{seven_day_kickstarter_count: 43, seven_day_kickstarter_subscribed: false, subscribed: false, subscriber_email: "some updated subscriber_email", ten_day_meditation_count: 43, ten_day_meditation_subscribed: false, twenty_eight_day_awareness_count: 43, twenty_eight_day_awareness_subscribed: false}
    @invalid_attrs %{seven_day_kickstarter_count: nil, seven_day_kickstarter_subscribed: nil, subscribed: nil, subscriber_email: nil, ten_day_meditation_count: nil, ten_day_meditation_subscribed: nil, twenty_eight_day_awareness_count: nil, twenty_eight_day_awareness_subscribed: nil}

    def subscriber_fixture(attrs \\ %{}) do
      {:ok, subscriber} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Account.create_subscriber()

      subscriber
    end

    test "list_subscribers/0 returns all subscribers" do
      subscriber = subscriber_fixture()
      assert Account.list_subscribers() == [subscriber]
    end

    test "get_subscriber!/1 returns the subscriber with given id" do
      subscriber = subscriber_fixture()
      assert Account.get_subscriber!(subscriber.id) == subscriber
    end

    test "create_subscriber/1 with valid data creates a subscriber" do
      assert {:ok, %Subscriber{} = subscriber} = Account.create_subscriber(@valid_attrs)
      assert subscriber.seven_day_kickstarter_count == 42
      assert subscriber.seven_day_kickstarter_subscribed == true
      assert subscriber.subscribed == true
      assert subscriber.subscriber_email == "some subscriber_email"
      assert subscriber.ten_day_meditation_count == 42
      assert subscriber.ten_day_meditation_subscribed == true
      assert subscriber.twenty_eight_day_awareness_count == 42
      assert subscriber.twenty_eight_day_awareness_subscribed == true
    end

    test "create_subscriber/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_subscriber(@invalid_attrs)
    end

    test "update_subscriber/2 with valid data updates the subscriber" do
      subscriber = subscriber_fixture()
      assert {:ok, %Subscriber{} = subscriber} = Account.update_subscriber(subscriber, @update_attrs)
      assert subscriber.seven_day_kickstarter_count == 43
      assert subscriber.seven_day_kickstarter_subscribed == false
      assert subscriber.subscribed == false
      assert subscriber.subscriber_email == "some updated subscriber_email"
      assert subscriber.ten_day_meditation_count == 43
      assert subscriber.ten_day_meditation_subscribed == false
      assert subscriber.twenty_eight_day_awareness_count == 43
      assert subscriber.twenty_eight_day_awareness_subscribed == false
    end

    test "update_subscriber/2 with invalid data returns error changeset" do
      subscriber = subscriber_fixture()
      assert {:error, %Ecto.Changeset{}} = Account.update_subscriber(subscriber, @invalid_attrs)
      assert subscriber == Account.get_subscriber!(subscriber.id)
    end

    test "delete_subscriber/1 deletes the subscriber" do
      subscriber = subscriber_fixture()
      assert {:ok, %Subscriber{}} = Account.delete_subscriber(subscriber)
      assert_raise Ecto.NoResultsError, fn -> Account.get_subscriber!(subscriber.id) end
    end

    test "change_subscriber/1 returns a subscriber changeset" do
      subscriber = subscriber_fixture()
      assert %Ecto.Changeset{} = Account.change_subscriber(subscriber)
    end
  end

  describe "contact_form" do
    alias Nfd.Account.ContactForm

    @valid_attrs %{email: "some email", message: "some message", name: "some name"}
    @update_attrs %{email: "some updated email", message: "some updated message", name: "some updated name"}
    @invalid_attrs %{email: nil, message: nil, name: nil}

    def contact_form_fixture(attrs \\ %{}) do
      {:ok, contact_form} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Account.create_contact_form()

      contact_form
    end

    test "list_contact_form/0 returns all contact_form" do
      contact_form = contact_form_fixture()
      assert Account.list_contact_form() == [contact_form]
    end

    test "get_contact_form!/1 returns the contact_form with given id" do
      contact_form = contact_form_fixture()
      assert Account.get_contact_form!(contact_form.id) == contact_form
    end

    test "create_contact_form/1 with valid data creates a contact_form" do
      assert {:ok, %ContactForm{} = contact_form} = Account.create_contact_form(@valid_attrs)
      assert contact_form.email == "some email"
      assert contact_form.message == "some message"
      assert contact_form.name == "some name"
    end

    test "create_contact_form/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_contact_form(@invalid_attrs)
    end

    test "update_contact_form/2 with valid data updates the contact_form" do
      contact_form = contact_form_fixture()
      assert {:ok, %ContactForm{} = contact_form} = Account.update_contact_form(contact_form, @update_attrs)
      assert contact_form.email == "some updated email"
      assert contact_form.message == "some updated message"
      assert contact_form.name == "some updated name"
    end

    test "update_contact_form/2 with invalid data returns error changeset" do
      contact_form = contact_form_fixture()
      assert {:error, %Ecto.Changeset{}} = Account.update_contact_form(contact_form, @invalid_attrs)
      assert contact_form == Account.get_contact_form!(contact_form.id)
    end

    test "delete_contact_form/1 deletes the contact_form" do
      contact_form = contact_form_fixture()
      assert {:ok, %ContactForm{}} = Account.delete_contact_form(contact_form)
      assert_raise Ecto.NoResultsError, fn -> Account.get_contact_form!(contact_form.id) end
    end

    test "change_contact_form/1 returns a contact_form changeset" do
      contact_form = contact_form_fixture()
      assert %Ecto.Changeset{} = Account.change_contact_form(contact_form)
    end
  end
end
