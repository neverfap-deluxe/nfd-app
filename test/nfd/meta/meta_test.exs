defmodule Nfd.MetaTest do
  use Nfd.DataCase

  alias Nfd.Meta

  describe "pages" do
    alias Nfd.Meta.Page

    @valid_attrs %{page_id: "some page_id", visit_count: 42}
    @update_attrs %{page_id: "some updated page_id", visit_count: 43}
    @invalid_attrs %{page_id: nil, visit_count: nil}

    def page_fixture(attrs \\ %{}) do
      {:ok, page} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Meta.create_page()

      page
    end

    test "list_pages/0 returns all pages" do
      page = page_fixture()
      assert Meta.list_pages() == [page]
    end

    test "get_page!/1 returns the page with given id" do
      page = page_fixture()
      assert Meta.get_page!(page.id) == page
    end

    test "create_page/1 with valid data creates a page" do
      assert {:ok, %Page{} = page} = Meta.create_page(@valid_attrs)
      assert page.page_id == "some page_id"
      assert page.visit_count == 42
    end

    test "create_page/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Meta.create_page(@invalid_attrs)
    end

    test "update_page/2 with valid data updates the page" do
      page = page_fixture()
      assert {:ok, %Page{} = page} = Meta.update_page(page, @update_attrs)
      assert page.page_id == "some updated page_id"
      assert page.visit_count == 43
    end

    test "update_page/2 with invalid data returns error changeset" do
      page = page_fixture()
      assert {:error, %Ecto.Changeset{}} = Meta.update_page(page, @invalid_attrs)
      assert page == Meta.get_page!(page.id)
    end

    test "delete_page/1 deletes the page" do
      page = page_fixture()
      assert {:ok, %Page{}} = Meta.delete_page(page)
      assert_raise Ecto.NoResultsError, fn -> Meta.get_page!(page.id) end
    end

    test "change_page/1 returns a page changeset" do
      page = page_fixture()
      assert %Ecto.Changeset{} = Meta.change_page(page)
    end
  end

  describe "subscription_emails" do
    alias Nfd.Meta.SubscriptionEmail

    @valid_attrs %{course: "some course", day: 42, subscription_email: "some subscription_email"}
    @update_attrs %{course: "some updated course", day: 43, subscription_email: "some updated subscription_email"}
    @invalid_attrs %{course: nil, day: nil, subscription_email: nil}

    def subscription_email_fixture(attrs \\ %{}) do
      {:ok, subscription_email} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Meta.create_subscription_email()

      subscription_email
    end

    test "list_subscription_emails/0 returns all subscription_emails" do
      subscription_email = subscription_email_fixture()
      assert Meta.list_subscription_emails() == [subscription_email]
    end

    test "get_subscription_email!/1 returns the subscription_email with given id" do
      subscription_email = subscription_email_fixture()
      assert Meta.get_subscription_email!(subscription_email.id) == subscription_email
    end

    test "create_subscription_email/1 with valid data creates a subscription_email" do
      assert {:ok, %SubscriptionEmail{} = subscription_email} = Meta.create_subscription_email(@valid_attrs)
      assert subscription_email.course == "some course"
      assert subscription_email.day == 42
      assert subscription_email.subscription_email == "some subscription_email"
    end

    test "create_subscription_email/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Meta.create_subscription_email(@invalid_attrs)
    end

    test "update_subscription_email/2 with valid data updates the subscription_email" do
      subscription_email = subscription_email_fixture()
      assert {:ok, %SubscriptionEmail{} = subscription_email} = Meta.update_subscription_email(subscription_email, @update_attrs)
      assert subscription_email.course == "some updated course"
      assert subscription_email.day == 43
      assert subscription_email.subscription_email == "some updated subscription_email"
    end

    test "update_subscription_email/2 with invalid data returns error changeset" do
      subscription_email = subscription_email_fixture()
      assert {:error, %Ecto.Changeset{}} = Meta.update_subscription_email(subscription_email, @invalid_attrs)
      assert subscription_email == Meta.get_subscription_email!(subscription_email.id)
    end

    test "delete_subscription_email/1 deletes the subscription_email" do
      subscription_email = subscription_email_fixture()
      assert {:ok, %SubscriptionEmail{}} = Meta.delete_subscription_email(subscription_email)
      assert_raise Ecto.NoResultsError, fn -> Meta.get_subscription_email!(subscription_email.id) end
    end

    test "change_subscription_email/1 returns a subscription_email changeset" do
      subscription_email = subscription_email_fixture()
      assert %Ecto.Changeset{} = Meta.change_subscription_email(subscription_email)
    end
  end
end
