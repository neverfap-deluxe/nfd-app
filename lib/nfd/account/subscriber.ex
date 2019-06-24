defmodule Nfd.Account.Subscriber do
  use Ecto.Schema
  import Ecto.Changeset

  alias Nfd.Account
  alias Nfd.Account.Subscriber

  alias Nfd.EmailLogs

  alias NfdWeb.Patreon

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "subscribers" do
    field :subscriber_email, :string
    field :subscribed, :boolean, default: false

    # Free
    field :free_active, :string # seven_day_kickstarter_subscribed
    field :seven_day_kickstarter_subscribed, :boolean, default: false
    field :seven_day_kickstarter_count, :integer, default: 0
    field :seven_day_kickstarter_up_to_count, :integer, default: 0

    # Meditations
    field :meditation_active, :string # ten_day_meditation_subscribed
    field :ten_day_meditation_subscribed, :boolean, default: false
    field :ten_day_meditation_count, :integer, default: 0
    field :ten_day_meditation_up_to_count, :integer, default: 0

    # Awareness
    field :awareness_active, :string # awareness_seven_week_vol_1_subscribed, awareness_seven_week_vol_2_subscribed, awareness_seven_week_vol_3_subscribed, awareness_seven_week_vol_4_subscribed, twenty_eight_day_awareness_subscribed
    field :awareness_seven_week_vol_1_subscribed, :boolean, default: false
    field :awareness_seven_week_vol_1_count, :integer, default: 0
    field :awareness_seven_week_vol_1_up_to_count, :integer, default: 0

    field :awareness_seven_week_vol_2_subscribed, :boolean, default: false
    field :awareness_seven_week_vol_2_count, :integer, default: 0
    field :awareness_seven_week_vol_2_up_to_count, :integer, default: 0

    field :awareness_seven_week_vol_3_subscribed, :boolean, default: false
    field :awareness_seven_week_vol_3_count, :integer, default: 0
    field :awareness_seven_week_vol_3_up_to_count, :integer, default: 0

    field :awareness_seven_week_vol_4_subscribed, :boolean, default: false
    field :awareness_seven_week_vol_4_count, :integer, default: 0
    field :awareness_seven_week_vol_4_up_to_count, :integer, default: 0

    field :twenty_eight_day_awareness_subscribed, :boolean, default: false
    field :twenty_eight_day_awareness_count, :integer, default: 0
    field :twenty_eight_day_awareness_up_to_count, :integer, default: 0

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

      :free_active,
      :seven_day_kickstarter_subscribed,
      :seven_day_kickstarter_count,
      :seven_day_kickstarter_up_to_count,

      :meditation_active,
      :ten_day_meditation_subscribed,
      :ten_day_meditation_count,
      :ten_day_meditation_up_to_count,

      :awareness_active,
      :awareness_seven_week_vol_1_subscribed,
      :awareness_seven_week_vol_1_count,
      :awareness_seven_week_vol_1_up_to_count,
      :awareness_seven_week_vol_2_subscribed,
      :awareness_seven_week_vol_2_count,
      :awareness_seven_week_vol_2_up_to_count,
      :awareness_seven_week_vol_3_subscribed,
      :awareness_seven_week_vol_3_count,
      :awareness_seven_week_vol_3_up_to_count,
      :awareness_seven_week_vol_4_subscribed,
      :awareness_seven_week_vol_4_count,
      :awareness_seven_week_vol_4_up_to_count,
      :twenty_eight_day_awareness_subscribed,
      :twenty_eight_day_awareness_count,
      :twenty_eight_day_awareness_up_to_count,

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
    if Map.has_key?(user, :email) do
      case Account.get_subscriber_email(Map.get(user, :email)) do
        nil -> check_subscriber_exists_create_subscriber(user.email, user.id)
        subscriber -> check_subscriber_exists_update_subscriber(subscriber, user)
      end
    else
      %{}
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

  # NOTE need to figure out how to pass in collection based on the collection type.
  def check_if_subscriber_has_paid(subscriber, collection) do
    # TODO: Test this and see if it works
    host = if Mix.env() == :dev, do: "localhost", else: "neverfapdeluxe.com"
    user = Account.get_user_email(subscriber.subscriber_email)
    patreon_access = Patreon.fetch_patreon(host, user)
    has_paid_for_collection = Collection.has_paid_for_collection(collection, %{ collections_access_list: Account.list_collection_access_by_user_id(user.id) })
    if has_paid_for_collection != nil or patreon_access.tier_access_list |> Enum.find(&(&1 == :courses_access)), do: true, else: false

    # Still need to complete logic and check for both patreon access and the other one.
  end

  def get_subscriber_changeset(acc, symbol) do
    Map.put(acc, symbol, Subscriber.changeset(%Subscriber{}, %{}))
  end
end
