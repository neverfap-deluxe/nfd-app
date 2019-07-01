defmodule Nfd.Meta.ManualEmails do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "manual_emails" do
    field :message, :string
    field :subject, :string
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(manual_emails, attrs) do
    manual_emails
    |> cast(attrs, [:type, :subject, :message])
    |> validate_required([:type, :subject, :message])
  end
end
