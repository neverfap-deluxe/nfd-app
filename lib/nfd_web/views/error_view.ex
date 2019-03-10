defmodule NfdWeb.ErrorView do
  use NfdWeb, :view

  # If you want to customize a particular status code
  # for a certain format, you may uncomment below.
  # def render("500.html", _assigns) do
  #   "Internal Server Error"
  # end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.html" becomes
  # "Not Found".
  def template_not_found(template, _assigns) do
    Phoenix.Controller.status_message_from_template(template)
  end

  # def render("404.html", _assigns) do
  #   render("404.html")
  # end

  # def render("500.html", _assigns) do
  #   "Server internal error"
  # end
end
