defmodule Nfd.MetaTest do
  use Nfd.DataCase

  alias Nfd.Meta

  describe "manual_emails" do
    alias Nfd.Meta.ManualEmails

    @valid_attrs %{message: "some message", type: "some type"}
    @update_attrs %{message: "some updated message", type: "some updated type"}
    @invalid_attrs %{message: nil, type: nil}

    def manual_emails_fixture(attrs \\ %{}) do
      {:ok, manual_emails} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Meta.create_manual_emails()

      manual_emails
    end

    test "list_manual_emails/0 returns all manual_emails" do
      manual_emails = manual_emails_fixture()
      assert Meta.list_manual_emails() == [manual_emails]
    end

    test "get_manual_emails!/1 returns the manual_emails with given id" do
      manual_emails = manual_emails_fixture()
      assert Meta.get_manual_emails!(manual_emails.id) == manual_emails
    end

    test "create_manual_emails/1 with valid data creates a manual_emails" do
      assert {:ok, %ManualEmails{} = manual_emails} = Meta.create_manual_emails(@valid_attrs)
      assert manual_emails.message == "some message"
      assert manual_emails.type == "some type"
    end

    test "create_manual_emails/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Meta.create_manual_emails(@invalid_attrs)
    end

    test "update_manual_emails/2 with valid data updates the manual_emails" do
      manual_emails = manual_emails_fixture()
      assert {:ok, %ManualEmails{} = manual_emails} = Meta.update_manual_emails(manual_emails, @update_attrs)
      assert manual_emails.message == "some updated message"
      assert manual_emails.type == "some updated type"
    end

    test "update_manual_emails/2 with invalid data returns error changeset" do
      manual_emails = manual_emails_fixture()
      assert {:error, %Ecto.Changeset{}} = Meta.update_manual_emails(manual_emails, @invalid_attrs)
      assert manual_emails == Meta.get_manual_emails!(manual_emails.id)
    end

    test "delete_manual_emails/1 deletes the manual_emails" do
      manual_emails = manual_emails_fixture()
      assert {:ok, %ManualEmails{}} = Meta.delete_manual_emails(manual_emails)
      assert_raise Ecto.NoResultsError, fn -> Meta.get_manual_emails!(manual_emails.id) end
    end

    test "change_manual_emails/1 returns a manual_emails changeset" do
      manual_emails = manual_emails_fixture()
      assert %Ecto.Changeset{} = Meta.change_manual_emails(manual_emails)
    end
  end
end
