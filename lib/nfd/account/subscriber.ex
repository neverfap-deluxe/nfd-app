defmodule Nfd.Account.Subscriber do
  use Ecto.Schema
  import Ecto.Changeset

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
    
    field :three_day_awareness_subscribed, :boolean, default: false
    field :three_day_awareness_count, :integer, default: 0
    field :three_day_calmness_subscribed, :boolean, default: false
    field :three_day_calmness_count, :integer, default: 0
    field :three_day_meditation_subscribed, :boolean, default: false
    field :three_day_meditation_count, :integer, default: 0

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
      :three_day_awareness_subscribed,
      :three_day_awareness_count,
      :three_day_calmness_subscribed,
      :three_day_calmness_count,
      :three_day_meditation_subscribed,
      :three_day_meditation_count
    ])
    |> validate_required([:subscriber_email])
  end
end
