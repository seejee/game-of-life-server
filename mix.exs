defmodule ConwayServer.Mixfile do
  use Mix.Project

  def project do
    [app: :conway_server,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: ["lib", "web"],
     compilers: [:phoenix] ++ Mix.compilers,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {ConwayServer, []},
     applications: [:phoenix, :cowboy, :logger]]
  end

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [
     {:phoenix, "0.9.0"},
     {:plug,    "0.10.0"},
     {:exprof,  github: "parroty/exprof"},
     {:cowboy,  "~> 1.0"}
   ]
  end
end
