defmodule Nfd.API.Page do
  use Tesla

  # GENERAL
  def home(client), do: get(client, "/index.json")
  def community(client), do: get(client, "/community/index.json")
  def about(client), do: get(client, "/about/index.json")
  def contact(client), do: get(client, "/contact/index.json")
  def donations(client), do: get(client, "/donations/index.json")
  def everything(client), do: get(client, "/everything/index.json")

  # GUIDE
  def guide(client), do: get(client, "/guide/index.json")
  def summary(client), do: get(client, "/summary/index.json")
  def neverfap_deluxe_bible(client), do: get(client, "/neverfap_deluxe_bible/index.json")
  def post_relapse_academy(client), do: get(client, "/post_relapse_academy/index.json")
  def emergency(client), do: get(client, "/emergency/index.json")

  # PROGRAMS
  def accountability(client), do: get(client, "/accountability/index.json")
  def reddit_guidelines(client), do: get(client, "/reddit_guidelines/index.json")
  def coaching(client), do: get(client, "/coaching/index.json")

  # VOLUNTEER
  def helpful_neverfap_counsel(client), do: get(client, "/helpful_neverfap_counsel/index.json")
  def engineering_corps(client), do: get(client, "/engineering_corps/index.json")
  def marketing_department(client), do: get(client, "/marketing_department/index.json")

  # APPS
  def desktop_app(client), do: get(client, "/desktop_app/index.json")
  def mobile_app(client), do: get(client, "/mobile_app/index.json")
  def chrome_extension(client), do: get(client, "/chrome_extension/index.json")
  def neverfap_deluxe_league(client), do: get(client, "/neverfap_deluxe_league/index.json")
  def open_source(client), do: get(client, "/open_source/index.json")

  # MISC
  def never_fap(client), do: get(client, "/never_fap/index.json")

  # LEGAL
  def disclaimer(client), do: get(client, "/disclaimer/index.json")
  def privacy(client), do: get(client, "/privacy/index.json")
  def terms_and_conditions(client), do: get(client, "/terms_and_conditions/index.json")
end
