defmodule Nfd.API.Page do
  use Tesla

  def home(client) do
    get(client, "/index.json")
  end

  def guide(client) do
    get(client, "/guide/index.json")
  end

  def community(client) do
    get(client, "/community/index.json")
  end

  def about(client) do
    get(client, "/about/index.json")
  end

  def contact(client) do
    get(client, "/contact/index.json")
  end

  def disclaimer(client) do
    get(client, "/disclaimer/index.json")
  end

  def privacy(client) do
    get(client, "/privacy/index.json")
  end

  def terms_and_conditions(client) do
    get(client, "/terms_and_conditions/index.json")
  end

  def account(client) do
    get(client, "/account/index.json")
  end

  def accountability(client) do
    get(client, "/accountability/index.json")
  end

  def reddit_guidelines(client) do
    get(client, "/reddit_guidelines/index.json")
  end

  def everything(client) do
    get(client, "/everything/index.json")
  end

  def coaching(client) do
    get(client, "/coaching/index.json")
  end

  def post_relapse_academy(client) do
    get(client, "/post_relapse_academy/index.json")
  end

  def emergency(client) do
    get(client, "/emergency/index.json")
  end  
end
