defmodule Nfd.MixProject do
  use Mix.Project

  def project do
    [
      app: :nfd,
      version: "0.1.0",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Nfd.Application, []},
      extra_applications: [:logger, :runtime_tools, :confex]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.4.1"},
      {:phoenix_pubsub, "~> 1.1"},
      {:phoenix_ecto, "~> 4.0"},
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 2.11"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:gettext, "~> 0.11"},
      {:tesla, "~> 1.2.1"},
      {:jason, "~> 1.0"},
      {:plug_cowboy, "~> 2.0"},

      # user authentication
      {:pow, "~> 1.0.1"},
      {:pow_assent, "~> 0.1.0-rc.2"},
      {:swoosh, "~> 0.21"},
      {:phoenix_swoosh, "~> 0.2"},
      {:gen_smtp, "~> 0.12"},
      {:certifi, "~> 2.4", override: true},
      {:ssl_verify_fun, "~> 1.1"},

      # stripe
      {:stripity_stripe, "~> 2.0.0"},

      {:quantum, "~> 2.3"},
      {:timex, "~> 3.0"},
      {:sitemap, "~> 1.1"},
      {:confex, "~> 3.4.0"},
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
