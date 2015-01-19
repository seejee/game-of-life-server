defmodule ConwayServer.GameServer do
  use ExActor.GenServer, export: :conway_game_server

  alias ConwayServer.Game

  defstart start_link, do: initial_state(Game.random(1000,1000))

  defcall get, state: game do
    game |> reply
  end

  defcast tick, state: game do
    game |> Game.tick |> new_state
  end
end
