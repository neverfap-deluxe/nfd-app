defmodule NfdWeb.FetchCollectionUtil do

  # fetch_content_collections
  # fetch_changeset_collections

  def merge_collection(client, content_symbol, acc, item) do
    {:ok, response} = apply(Page, content_symbol, [client])
    collections = response.body["data"][Atom.to_string(content_symbol)] |> Enum.reverse()
    { previous_item, next_item } = Nfd.Meta.Page.previous_next_item(collections, item);
    Map.merge(acc, %{
      content_symbol => collections,
      next_item: next_item,
      previous_item: previous_item
    })
  end

  defp fetch_content_email(acc, client, symbol) do
    {:ok, response} = apply(Page, symbol, [client])
    data = response.body["data"]
    Map.put(acc, :seven_day_kickstarter, data)
  end

  defp fetch_subscriber_changeset(acc, symbol) do
    Map.put(acc, symbol, Subscriber.changeset(%Subscriber{}, %{}))
  end



  

end
