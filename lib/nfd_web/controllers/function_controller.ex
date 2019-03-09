defmodule NfdWeb.FunctionController do
  use NfdWeb, :controller

  alias Nfd.Content
  alias Nfd.Account

  def kickstarter_subscribe(conn, %{"email" => email}) do
    # subscriber = Account.get_subscriber_user_id!(user_id)
  end

  def change_subscription(conn, %{"subscribed" => subscribed, "user_id" => user_id}) do
    subscriber = Account.get_subscriber_user_id!(user_id)
    
    if subscribed == "true", do: Account.update_subscriber(subscriber, %{ subscribed: false })
    if subscribed == "false", do: Account.update_subscriber(subscriber, %{ subscribed: true }) 

    redirect(conn, to: Routes.dashboard_path(conn, :dashboard))
  end

end
