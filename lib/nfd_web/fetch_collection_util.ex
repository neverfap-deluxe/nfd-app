defmodule NfdWeb.FetchCollectionUtil do

  def merge_collection(acc, client, content_symbol, item) do
    {:ok, response} = apply(Page, content_symbol, [client])
    collections = response.body["data"][Atom.to_string(content_symbol)] |> Enum.reverse()
    { previous_item, next_item } = Nfd.Meta.Page.previous_next_item(collections, item);

    Map.merge(acc, %{ content_symbol => collections |> Map.merge(%{previous_item: previous_item, next_item: next_item}) })
  end

  def fetch_content_email(acc, client, symbol) do
    {:ok, response} = apply(Page, symbol, [client])
    Map.put(acc, :seven_day_kickstarter, response.body["data"])
  end

  def fetch_subscriber_changeset(acc, symbol) do
    Map.put(acc, symbol, Subscriber.changeset(%Subscriber{}, %{}))
  end

end
