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

      def redirect_back(conn, opts \\ []) do
        redirect(conn, to: NavigationHistory.last_path(conn, opts))
      end
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

      use Timex
      import NfdWeb.ErrorHelpers
      import NfdWeb.Gettext
      alias NfdWeb.Router.Helpers, as: Routes

      # Add custom functionality for partials
      def partial(template, assigns \\ []) do
        render(NfdWeb.PartialView, template, assigns)
      end

      # TODO: Add anything missing here.
      def page_title(section, title) do
        pre_title =
          case section do
            "content_courses" ->
              "NeverFap Deluxe Courses | "

            "content_articles" ->
              "NeverFap Deluxe Articles | "

            "content_practices" ->
              "NeverFap Deluxe Practices | "

            "content_podcast" ->
              "NeverFap Deluxe Podcast | "

            "content_quotes" ->
              "NeverFap Deluxe Quotes | "

            "content_meditations" ->
              "NeverFap Deluxe Meditations | "

            "content_blogs" ->
              "NeverFap Deluxe Blogs | "

            "content_updates" ->
              "NeverFap Deluxe Updates | "

            _ ->
              "NeverFap Deluxe | "
          end

          pre_title <> title
      end

      def child_content(list, name) do
        Enum.find(list, fn(item) -> item["slug"] == name end)["content"]
      end

      def child_title(list, name) do
        Enum.find(list, fn(item) -> item["slug"] == name end)["title"]
      end

      def is_new(date) do
        split_date = String.split(date, "-")

        { year, _yes } = Enum.fetch!(split_date, 0) |> Integer.parse()
        { month, _yes } = Enum.fetch!(split_date, 1) |> Integer.parse()
        { day, _yes } = Enum.fetch!(split_date, 2) |> Integer.parse()

        {:ok, elixir_date} = Date.new(year, month, day)

        week_before_today = Date.add(Date.utc_today(), -7)

        if Timex.after?(elixir_date, week_before_today) do
          "new__collection__item"
        else
          "none"
        end
      end

      def has_premium_access(item_collections, user_collections, access_type) do
        if item_collections.has_paid_for_collection != nil or patreon_access_list(user_collections, access_type), do: true, else: false
      end

      def patreon_access_list(user_collections, type) do 
        user_collections.patreon_access.tier_access_list |> Enum.find(&(&1 == type))
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
