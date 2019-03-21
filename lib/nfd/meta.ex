defmodule Nfd.Meta do
  @moduledoc """
  The Meta context.
  """

  import Ecto.Query, warn: false
  alias Nfd.Repo

  alias Nfd.Meta.Page

  def increment_visit_count(page), do: get_page_by_page_id(page["page_id"]) |> increment_page_count(page)
  def increment_page_count(nil, originalPage), do: create_page(%{ page_id: originalPage["page_id"], page_title: originalPage["title"], visit_count: 1 })
  def increment_page_count(page, page_id), do: update_page(page, %{ visit_count: page.visit_count + 1 })
  
  @doc """
  Returns the list of pages.

  ## Examples

      iex> list_pages()
      [%Page{}, ...]

  """
  def list_pages do
    Repo.all(Page)
  end

  @doc """
  Gets a single page.

  Raises `Ecto.NoResultsError` if the Page does not exist.

  ## Examples

      iex> get_page!(123)
      %Page{}

      iex> get_page!(456)
      ** (Ecto.NoResultsError)

  """
  def get_page!(id), do: Repo.get!(Page, id)
  def get_page_by_page_id(page_id), do: Repo.get_by(Page, page_id: page_id)

  @doc """
  Creates a page.

  ## Examples

      iex> create_page(%{field: value})
      {:ok, %Page{}}

      iex> create_page(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_page(attrs \\ %{}) do
    %Page{}
    |> Page.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a page.

  ## Examples

      iex> update_page(page, %{field: new_value})
      {:ok, %Page{}}

      iex> update_page(page, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_page(%Page{} = page, attrs) do
    page
    |> Page.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Page.

  ## Examples

      iex> delete_page(page)
      {:ok, %Page{}}

      iex> delete_page(page)
      {:error, %Ecto.Changeset{}}

  """
  def delete_page(%Page{} = page) do
    Repo.delete(page)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking page changes.

  ## Examples

      iex> change_page(page)
      %Ecto.Changeset{source: %Page{}}

  """
  def change_page(%Page{} = page) do
    Page.changeset(page, %{})
  end

  alias Nfd.Meta.SubscriptionEmail

  @doc """
  Returns the list of subscription_emails.

  ## Examples

      iex> list_subscription_emails()
      [%SubscriptionEmail{}, ...]

  """
  def list_subscription_emails do
    Repo.all(SubscriptionEmail)
  end

  @doc """
  Gets a single subscription_email.

  Raises `Ecto.NoResultsError` if the Subscription email does not exist.

  ## Examples

      iex> get_subscription_email!(123)
      %SubscriptionEmail{}

      iex> get_subscription_email!(456)
      ** (Ecto.NoResultsError)

  """
  def get_subscription_email!(id), do: Repo.get!(SubscriptionEmail, id)
  def get_subscription_email_latest(course, subscription_email) do
    # TODO: figure out how to use Repo.get, this is incorrect.
    Repo.get(
      from s in SubscriptionEmail,
      where: [ course: ^course, subscription_email: ^subscription_email]
    )
  end
  

  @doc """
  Creates a subscription_email.

  ## Examples

      iex> create_subscription_email(%{field: value})
      {:ok, %SubscriptionEmail{}}

      iex> create_subscription_email(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_subscription_email(attrs \\ %{}) do
    %SubscriptionEmail{}
    |> SubscriptionEmail.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a subscription_email.

  ## Examples

      iex> update_subscription_email(subscription_email, %{field: new_value})
      {:ok, %SubscriptionEmail{}}

      iex> update_subscription_email(subscription_email, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_subscription_email(%SubscriptionEmail{} = subscription_email, attrs) do
    subscription_email
    |> SubscriptionEmail.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a SubscriptionEmail.

  ## Examples

      iex> delete_subscription_email(subscription_email)
      {:ok, %SubscriptionEmail{}}

      iex> delete_subscription_email(subscription_email)
      {:error, %Ecto.Changeset{}}

  """
  def delete_subscription_email(%SubscriptionEmail{} = subscription_email) do
    Repo.delete(subscription_email)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking subscription_email changes.

  ## Examples

      iex> change_subscription_email(subscription_email)
      %Ecto.Changeset{source: %SubscriptionEmail{}}

  """
  def change_subscription_email(%SubscriptionEmail{} = subscription_email) do
    SubscriptionEmail.changeset(subscription_email, %{})
  end
end
