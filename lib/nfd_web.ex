defmodule NfdWeb do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, views, channels and so on.

  This can be used in your application as:

      use NfdWeb, :controller
      use NfdWeb, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define any helper function in modules
  and import those modules here.
  """

  def controller do
    quote do
      use Phoenix.Controller, namespace: NfdWeb

      import Plug.Conn
      import NfdWeb.Gettext
      alias NfdWeb.Router.Helpers, as: Routes
    end
  end

  def view do
    quote do
      use Phoenix.View,
        root: "lib/nfd_web/templates",
        pattern: "**/*",
        namespace: NfdWeb

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_flash: 1, get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import NfdWeb.ErrorHelpers
      import NfdWeb.Gettext
      alias NfdWeb.Router.Helpers, as: Routes
    
      # Add custom functionality for partials
      def partial(template, assigns \\ []) do
        render(NfdWeb.PartialView, template, assigns)
      end

      def page_title(section, title) do
        pre_title = 
          case section do 
            "courses" ->
              "NeverFap Deluxe Courses | "
          
            "articles" -> 
              "NeverFap Deluxe Articles | "
          
            "practices" -> 
              "NeverFap Deluxe Practices | "
            
            "podcast" ->
              "NeverFap Deluxe Podcast | "

            "quotes" ->
              "NeverFap Deluxe Quotes | "

            _ ->
              "NeverFap Deluxe | "
          end 
          
          pre_title <> title
      end

      def iterate_json_collection(collection) do
        if length(collection) != 1 do 
          collection |> Enum.join(", ")
        else 
          "NeverFap Deluxe"
        end
      end
    end
  end

  def mailer_view do
    quote do
      use Phoenix.View, root: "lib/nfd_web/templates",
                        namespace: NfdWeb
      use Phoenix.HTML
    end
  end


  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import NfdWeb.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
