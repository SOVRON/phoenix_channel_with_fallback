defmodule Postgrex.Mixfile do
  use Mix.Project

  def project do
    [
      app: :phoenix_channel_with_fallback,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.14",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
      source_url: "https://github.com/SOVRON/phoenix_channel_with_fallback"
    ]
  end

  def application do
    []
  end

  defp deps do
    []
  end

  defp package do
    [
      maintainers: ["Nick Ewing"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/par8o/phoenix_channel_with_fallback"}
    ]
  end
end
