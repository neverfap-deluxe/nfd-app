defmodule Nfd.Account do
  @moduledoc """
  The Account context.
  """

  import Ecto.Query, warn: false
  alias Nfd.Repo

  alias Nfd.Account.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)
  def get_user_email(email), do: Repo.get_by(User, email: email)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def update_user_email_confirm(%User{} = user, attrs) do
    user 
    |> User.changeset_confirm_email(attrs)
    |> Repo.update()
  end
  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  alias Nfd.Account.CollectionAccess

  @doc """
  Returns the list of collection_access.

  ## Examples

      iex> list_collection_access()
      [%CollectionAccess{}, ...]

  """
  def list_collection_access do
    Repo.all(CollectionAccess)
  end

  @doc """
  Gets a single collection_access.

  Raises `Ecto.NoResultsError` if the Collection access does not exist.

  ## Examples

      iex> get_collection_access!(123)
      %CollectionAccess{}

      iex> get_collection_access!(456)
      ** (Ecto.NoResultsError)

  """
  def get_collection_access!(id), do: Repo.get!(CollectionAccess, id)

  @doc """
  Creates a collection_access.

  ## Examples

      iex> create_collection_access(%{field: value})
      {:ok, %CollectionAccess{}}

      iex> create_collection_access(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_collection_access(attrs \\ %{}) do
    %CollectionAccess{}
    |> CollectionAccess.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a collection_access.

  ## Examples

      iex> update_collection_access(collection_access, %{field: new_value})
      {:ok, %CollectionAccess{}}

      iex> update_collection_access(collection_access, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_collection_access(%CollectionAccess{} = collection_access, attrs) do
    collection_access
    |> CollectionAccess.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a CollectionAccess.

  ## Examples

      iex> delete_collection_access(collection_access)
      {:ok, %CollectionAccess{}}

      iex> delete_collection_access(collection_access)
      {:error, %Ecto.Changeset{}}

  """
  def delete_collection_access(%CollectionAccess{} = collection_access) do
    Repo.delete(collection_access)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking collection_access changes.

  ## Examples

      iex> change_collection_access(collection_access)
      %Ecto.Changeset{source: %CollectionAccess{}}

  """
  def change_collection_access(%CollectionAccess{} = collection_access) do
    CollectionAccess.changeset(collection_access, %{})
  end

  alias Nfd.Account.Subscriber

  @doc """
  Returns the list of subscribers.

  ## Examples

      iex> list_subscribers()
      [%Subscriber{}, ...]

  """
  def list_subscribers do
    Repo.all(Subscriber)
  end

  def list_subscribers_general do
    Repo.all(
      from s in Subscriber, 
      where: [ subscribed: true ]
    )
  end

  def list_subscribers_campaign do
    Repo.all(
      from s in Subscriber, 
      where: [ seven_day_kickstarter_subscribed: true ],
      or_where: [ ten_day_meditation_subscribed: true ],
      or_where: [ twenty_eight_day_awareness_subscribed: true ]
    )
  end


  @doc """
  Gets a single subscriber.

  Raises `Ecto.NoResultsError` if the Subscriber does not exist.

  ## Examples

      iex> get_subscriber!(123)
      %Subscriber{}

      iex> get_subscriber!(456)
      ** (Ecto.NoResultsError)

  """
  def get_subscriber!(id), do: Repo.get!(Subscriber, id)
  def get_subscriber_user_id!(user_id), do: Repo.get_by!(Subscriber, user_id: user_id)

  @doc """
  Creates a subscriber.

  ## Examples

      iex> create_subscriber(%{field: value})
      {:ok, %Subscriber{}}

      iex> create_subscriber(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_subscriber(attrs \\ %{}) do
    %Subscriber{}
    |> Subscriber.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a subscriber.

  ## Examples

      iex> update_subscriber(subscriber, %{field: new_value})
      {:ok, %Subscriber{}}

      iex> update_subscriber(subscriber, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_subscriber(%Subscriber{} = subscriber, attrs) do
    subscriber
    |> Subscriber.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Subscriber.

  ## Examples

      iex> delete_subscriber(subscriber)
      {:ok, %Subscriber{}}

      iex> delete_subscriber(subscriber)
      {:error, %Ecto.Changeset{}}

  """
  def delete_subscriber(%Subscriber{} = subscriber) do
    Repo.delete(subscriber)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking subscriber changes.

  ## Examples

      iex> change_subscriber(subscriber)
      %Ecto.Changeset{source: %Subscriber{}}

  """
  def change_subscriber(%Subscriber{} = subscriber) do
    Subscriber.changeset(subscriber, %{})
  end
end
