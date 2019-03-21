defmodule Mix.Tasks.Nfd.Sitemap do  
  use Mix.Task
  alias Nfd.Repo

  def run(_) do
    Mix.Task.run "app.start", []
    run_sitemap(Mix.env)
  end

  def run_sitemap(:dev) do  
    Nfd.Sitemaps.generate()
  end

  def run_sitemap(:prod) do
    Nfd.Sitemaps.generate()
  end
end  
