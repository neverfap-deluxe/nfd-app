defmodule Nfd.Account.Subscriber do
  use Ecto.Schema
  import Ecto.Changeset

  alias Nfd.Account
  alias Nfd.EmailLogs
  
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "subscribers" do
    field :subscriber_email, :string
    field :subscribed, :boolean, default: false
    field :seven_day_kickstarter_count, :integer, default: 0
    field :seven_day_kickstarter_subscribed, :boolean, default: false
    field :ten_day_meditation_count, :integer, default: 0
    field :ten_day_meditation_subscribed, :boolean, default: false
    field :twenty_eight_day_awareness_count, :integer, default: 0
    field :twenty_eight_day_awareness_subscribed, :boolean, default: false

    # field :three_day_awareness_subscribed, :boolean, default: false
    # field :three_day_awareness_count, :integer, default: 0
    # field :three_day_calmness_subscribed, :boolean, default: false
    # field :three_day_calmness_count, :integer, default: 0
    # field :three_day_meditation_subscribed, :boolean, default: false
    # field :three_day_meditation_count, :integer, default: 0

    # field :user_id, :binary_id
    belongs_to :user, Nfd.Account.User

    timestamps()
  end

  @doc false
  def changeset(subscriber, attrs) do
    subscriber
    |> cast(attrs,
    [
      :subscriber_email,
      :subscribed,
      :twenty_eight_day_awareness_subscribed,
      :twenty_eight_day_awareness_count,
      :seven_day_kickstarter_subscribed,
      :seven_day_kickstarter_count,
      :ten_day_meditation_subscribed,
      :ten_day_meditation_count,
      # :three_day_awareness_subscribed,
      # :three_day_awareness_count,
      # :three_day_calmness_subscribed,
      # :three_day_calmness_count,
      # :three_day_meditation_subscribed,
      # :three_day_meditation_count,
      :user_id
    ])
    |> validate_required([:subscriber_email])
  end

  # Check if subscriber exists
  def check_subscriber_exists(user) do
    # Check is subscriber email already exists.
    case Account.get_subscriber_email(user.email) do
      nil -> check_subscriber_exists_create_subscriber(user.email, user.id)
      subscriber -> check_subscriber_exists_update_subscriber(subscriber, user)
    end
  end

  defp check_subscriber_exists_create_subscriber(user_email, user_id) do
    case Account.create_subscriber(%{ subscriber_email: user_email, user_id: user_id }) do
      {:ok, subscriber} ->
        # NOTE: I think there's an issue where this only sometimes returns the subscriber_email.
        subscriber
      {:error, _error} -> EmailLogs.error_email_log("#{user_email} - #{user_id} - Could not create subscriber - :check_subscriber_exists_create_subscriber.")
    end
  end

  defp check_subscriber_exists_update_subscriber(subscriber, user) do
    if subscriber.user_id != user.id do
      case Account.update_subscriber(subscriber, %{user_id: user.id}) do
        {:ok, subscriber_with_user_id} -> subscriber_with_user_id
        {:error, _changeset} -> EmailLogs.error_email_log("#{subscriber.subscriber_email} - Could not update subscriber - :check_subscriber_exists_update_subscriber.")
      end
    else
      subscriber
    end
  end

end
