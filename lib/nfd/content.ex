defmodule Nfd.Content do
  @moduledoc """
  The Content context.
  """

  import Ecto.Query, warn: false
  alias Nfd.Repo

  alias Nfd.Content.Collection

  # def collection_slug_to_collection_access(collection_slug) do

  @doc """
  Returns the list of collections.

  ## Examples

      iex> list_collections()
      [%Collection{}, ...]

  """
  def list_collections do
    Repo.all(Collection)
  end

  def list_ebooks_with_files do
    Repo.all(from c in Collection, where: [type: "ebook_collection"], order_by: [asc: :status], select: [:active_type, :display_name, :price, :description, :status, :slug, :cover_image, :benefit_list])
  end

  def list_courses_with_files do
    Repo.all(from c in Collection, where: [type: "course_collection"], order_by: [asc: :status], select: [:active_type, :display_name, :price, :description, :status, :slug, :cover_image, :benefit_list])
  end

  @doc """
  Gets a single collection.

  Raises `Ecto.NoResultsError` if the Collection does not exist.

  ## Examples

      iex> get_collection!(123)
      %Collection{}

      iex> get_collection!(456)
      ** (Ecto.NoResultsError)

  """
  def get_collection!(id), do: Repo.get!(Collection, id)
  def get_collection_slug!(slug), do: Repo.get_by!(Collection, slug: slug)
  def get_collection_slug_with_files!(slug), do: Repo.get_by!(Collection, slug: slug) |> Repo.preload(:files)
  def get_collection_seed_id(seed_id), do: Repo.get_by(Collection, seed_id: seed_id)

  def get_collection_with_id_return_slug!(id), do: from(Collection) |> select([:slug]) |> Repo.get!(id)
  def get_collection_for_payment!(id), do: from(Collection) |> select([:price, :display_name]) |> Repo.get!(id)
  def get_collection_slug_return_collection_id!(slug), do: from(Collection) |> select([:id]) |> Repo.get_by!(slug: slug)


  
  @doc """
  Creates a collection.

  ## Examples

      iex> create_collection(%{field: value})
      {:ok, %Collection{}}

      iex> create_collection(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_collection(attrs \\ %{}) do
    %Collection{}
    |> Collection.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a collection.

  ## Examples

      iex> update_collection(collection, %{field: new_value})
      {:ok, %Collection{}}

      iex> update_collection(collection, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_collection(%Collection{} = collection, attrs) do
    collection
    |> Collection.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Collection.

  ## Examples

      iex> delete_collection(collection)
      {:ok, %Collection{}}

      iex> delete_collection(collection)
      {:error, %Ecto.Changeset{}}

  """
  def delete_collection(%Collection{} = collection) do
    Repo.delete(collection)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking collection changes.

  ## Examples

      iex> change_collection(collection)
      %Ecto.Changeset{source: %Collection{}}

  """
  def change_collection(%Collection{} = collection) do
    Collection.changeset(collection, %{})
  end

  alias Nfd.Content.File

  @doc """
  Returns the list of files.

  ## Examples

      iex> list_files()
      [%File{}, ...]

  """
  def list_files do
    Repo.all(File)
  end

  def list_files_with_collection_id_and_type(collection_id, type) do
    Repo.all(from File, where: [collection_id: ^collection_id, type: ^type], select: [:slug, :number, :display_name])
  end


  @doc """
  Gets a single file.

  Raises `Ecto.NoResultsError` if the File does not exist.

  ## Examples

      iex> get_file!(123)
      %File{}

      iex> get_file!(456)
      ** (Ecto.NoResultsError)

  """
  def get_file!(id), do: Repo.get!(File, id)
  def get_file_slug_with_collection!(slug), do: Repo.get_by!(File, slug: slug) |> Repo.preload(:collection)

  def get_file_slug_and_collection_id(collection_id, slug) do
    Repo.one(from f in File, where: [slug: ^slug, collection_id: ^collection_id], preload: [:collection])
  end


  @doc """
  Creates a file.

  ## Examples

      iex> create_file(%{field: value})
      {:ok, %File{}}

      iex> create_file(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_file(attrs \\ %{}) do
    %File{}
    |> File.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a file.

  ## Examples

      iex> update_file(file, %{field: new_value})
      {:ok, %File{}}

      iex> update_file(file, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_file(%File{} = file, attrs) do
    file
    |> File.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a File.

  ## Examples

      iex> delete_file(file)
      {:ok, %File{}}

      iex> delete_file(file)
      {:error, %Ecto.Changeset{}}

  """
  def delete_file(%File{} = file) do
    Repo.delete(file)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking file changes.

  ## Examples

      iex> change_file(file)
      %Ecto.Changeset{source: %File{}}

  """
  def change_file(%File{} = file) do
    File.changeset(file, %{})
  end
end
