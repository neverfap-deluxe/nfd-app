defmodule Nfd.Meta.SubscriptionEmail do
  use Ecto.Schema
  import Ecto.Changeset


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "subscription_emails" do
    field :course, :string
    field :day, :integer
    field :subscription_email, :string

    timestamps()
  end

  @doc false
  def changeset(subscription_email, attrs) do
    subscription_email
    |> cast(attrs, [:day, :course, :subscription_email])
    |> validate_required([:day, :course, :subscription_email])
  end
end
