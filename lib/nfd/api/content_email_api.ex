defmodule Nfd.API.ContentEmail do
  use Tesla

  def seven_day_kickstarter(client), do: get(client, "/seven_day_kickstarter/index.json")
  def seven_day_kickstarter_single(client, day), do: get(client, "/seven_day_kickstarter/" <> day <> "/index.json")

  def ten_day_meditation(client), do: get(client, "/ten_day_meditation/index.json")
  def ten_day_meditation_single(client, day), do: get(client, "/ten_day_meditation/" <> day <> "/index.json")

  def twenty_eight_day_awareness(client), do: get(client, "/twenty_eight_day_awareness/index.json")
  def twenty_eight_day_awareness_single(client, day), do: get(client, "/twenty_eight_day_awareness/" <> day <> "/index.json")
end
