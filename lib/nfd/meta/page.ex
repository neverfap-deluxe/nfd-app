defmodule Nfd.Meta.Page do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "pages" do
    field :page_id, :string
    field :page_title, :string
    field :visit_count, :integer

    timestamps()
  end

  @doc false
  def changeset(page, attrs) do
    page
    |> cast(attrs, [:page_id, :visit_count, :page_title])
    |> validate_required([:page_id, :visit_count, :page_title])
  end

  def previous_next_item(articles, current_article) do
    article_values =
      Enum.reduce(articles, %{last: nil, values: [], correct: false, previous_item: nil, next_item: nil}, fn article, acc ->
        if acc.correct do
          %{last: article, previous_item: acc.previous_item, next_item: article, correct: false }
        else
          if current_article["slug"] == article["slug"] do
            %{last: article, previous_item: acc.last, next_item: nil, correct: true }
          else
            %{last: article, previous_item: acc.previous_item, next_item: acc.next_item, correct: false}
          end
        end
      end)

    { article_values.previous_item, article_values.next_item }
  end

  def increment_visit_count(conn, responseBodyData) do
    Nfd.Meta.increment_visit_count(response.body["data"])
    conn
  end
end
