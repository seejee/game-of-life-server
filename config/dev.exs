use Mix.Config

config :conway_server, ConwayServer.Endpoint,
  http: [port: System.get_env("PORT") || 4000],
  debug_errors: true,
  cache_static_lookup: false,
  watchers: [{Path.expand("node_modules/brunch/bin/brunch"), ["watch"]}]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Watch static and templates for browser reloading.
# *Note*: Be careful with wildcards. Larger projects
# will use higher CPU in dev as the number of files
# grow. Adjust as necessary.
config :conway_server, ConwayServer.Endpoint,
  code_reloader: true,
  live_reload: [
    # url is optional
    url: "ws://localhost:4000",
    # `:patterns` replace `:paths` and are required for live reload
    patterns: [~r{priv/static/.*(js|css|png|jpeg|jpg|gif)$},
               ~r{web/views/.*(ex)$},
               ~r{web/templates/.*(eex)$}]]
