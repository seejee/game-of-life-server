defmodule ConwayServer.Endpoint do
  use Phoenix.Endpoint, otp_app: :conway_server

  plug Plug.Static,
    at: "/", from: :conway_server,
    only: ~w(css images js favicon.ico robots.txt)

  plug Plug.Logger

  # Code reloading will only work if the :code_reloader key of
  # the :phoenix application is set to true in your config file.
  plug Phoenix.CodeReloader

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_conway_server_key",
    signing_salt: "Zui4eWXs",
    encryption_salt: "UFduZExQ"

  plug :router, ConwayServer.Router

  if code_reloading? do
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end
end
