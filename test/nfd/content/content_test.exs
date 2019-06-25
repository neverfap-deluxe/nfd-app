defmodule Nfd.ContentTest do
  use Nfd.DataCase

  alias Nfd.Content

  describe "collections" do
    alias Nfd.Content.Collection

    @valid_attrs %{description: "some description", display_name: "some display_name", premium: true, slug: "some slug"}
    @update_attrs %{description: "some updated description", display_name: "some updated display_name", premium: false, slug: "some updated slug"}
    @invalid_attrs %{description: nil, display_name: nil, premium: nil, slug: nil}

    def collection_fixture(attrs \\ %{}) do
      {:ok, collection} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Content.create_collection()

      collection
    end

    test "list_collections/0 returns all collections" do
      collection = collection_fixture()
      assert Content.list_collections() == [collection]
    end

    test "get_collection!/1 returns the collection with given id" do
      collection = collection_fixture()
      assert Content.get_collection!(collection.id) == collection
    end

    test "create_collection/1 with valid data creates a collection" do
      assert {:ok, %Collection{} = collection} = Content.create_collection(@valid_attrs)
      assert collection.description == "some description"
      assert collection.display_name == "some display_name"
      assert collection.premium == true
      assert collection.slug == "some slug"
    end

    test "create_collection/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_collection(@invalid_attrs)
    end

    test "update_collection/2 with valid data updates the collection" do
      collection = collection_fixture()
      assert {:ok, %Collection{} = collection} = Content.update_collection(collection, @update_attrs)
      assert collection.description == "some updated description"
      assert collection.display_name == "some updated display_name"
      assert collection.premium == false
      assert collection.slug == "some updated slug"
    end

    test "update_collection/2 with invalid data returns error changeset" do
      collection = collection_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_collection(collection, @invalid_attrs)
      assert collection == Content.get_collection!(collection.id)
    end

    test "delete_collection/1 deletes the collection" do
      collection = collection_fixture()
      assert {:ok, %Collection{}} = Content.delete_collection(collection)
      assert_raise Ecto.NoResultsError, fn -> Content.get_collection!(collection.id) end
    end

    test "change_collection/1 returns a collection changeset" do
      collection = collection_fixture()
      assert %Ecto.Changeset{} = Content.change_collection(collection)
    end
  end

  describe "files" do
    alias Nfd.Content.File

    @valid_attrs %{description: "some description", display_name: "some display_name", download_count: "some download_count", b2_file_name: "some file_url", premium: true, slug: "some slug"}
    @update_attrs %{description: "some updated description", display_name: "some updated display_name", download_count: "some updated download_count", b2_file_name: "some updated file_url", premium: false, slug: "some updated slug"}
    @invalid_attrs %{description: nil, display_name: nil, download_count: nil, file_url: nil, premium: nil, slug: nil}

    def file_fixture(attrs \\ %{}) do
      {:ok, file} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Content.create_file()

      file
    end

    test "list_files/0 returns all files" do
      file = file_fixture()
      assert Content.list_files() == [file]
    end

    test "get_file!/1 returns the file with given id" do
      file = file_fixture()
      assert Content.get_file!(file.id) == file
    end

    test "create_file/1 with valid data creates a file" do
      assert {:ok, %File{} = file} = Content.create_file(@valid_attrs)
      assert file.description == "some description"
      assert file.display_name == "some display_name"
      assert file.download_count == "some download_count"
      assert file.file_url == "some file_url"
      assert file.premium == true
      assert file.slug == "some slug"
    end

    test "create_file/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_file(@invalid_attrs)
    end

    test "update_file/2 with valid data updates the file" do
      file = file_fixture()
      assert {:ok, %File{} = file} = Content.update_file(file, @update_attrs)
      assert file.description == "some updated description"
      assert file.display_name == "some updated display_name"
      assert file.download_count == "some updated download_count"
      assert file.file_url == "some updated file_url"
      assert file.premium == false
      assert file.slug == "some updated slug"
    end

    test "update_file/2 with invalid data returns error changeset" do
      file = file_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_file(file, @invalid_attrs)
      assert file == Content.get_file!(file.id)
    end

    test "delete_file/1 deletes the file" do
      file = file_fixture()
      assert {:ok, %File{}} = Content.delete_file(file)
      assert_raise Ecto.NoResultsError, fn -> Content.get_file!(file.id) end
    end

    test "change_file/1 returns a file changeset" do
      file = file_fixture()
      assert %Ecto.Changeset{} = Content.change_file(file)
    end
  end
end
