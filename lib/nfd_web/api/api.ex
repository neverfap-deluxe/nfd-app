defmodule NfdWeb.API do
  use Tesla

  def is_localhost(host) do
    if host == "localhost" do 
      "http://localhost:1313"
    else 
      "https://neverfapdeluxe.netlify.com"      
    end
  end

  def api_client(api_endpoint) do
    middleware = [
      {Tesla.Middleware.BaseUrl, api_endpoint},
      Tesla.Middleware.JSON,
    ]

    Tesla.client(middleware)
  end
end