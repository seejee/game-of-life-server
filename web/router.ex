defmodule ConwayServer.Router do
  use Phoenix.Router

  socket "/ws", ConwayServer do
    channel "game:*", GameChannel
  end

  pipeline :browser do
    plug :accepts, ~w(html)
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ~w(json)
  end

  scope "/", ConwayServer do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", ConwayServer do
  #   pipe_through :api
  # end
end
