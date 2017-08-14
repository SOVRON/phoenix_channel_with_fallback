defmodule Postgrex.Mixfile do
  use Mix.Project

  def project do
    [
      app: :phoenix_channel_with_fallback,
      version: "0.1.0",
      elixir: "~> 1.4",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      description: "Response fallback for Phoenix channel functions",
      package: package(),
      deps: deps(),
      name: "Phoenix Channel With Fallback",
      source_url: "https://github.com/par8o/phoenix_channel_with_fallback"
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
