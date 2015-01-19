defmodule ConwayServer.GameServer do
  use GenServer

  alias ConwayServer.Game

  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: :conway_game_server)
  end

  def init(_args) do
    game = Game.random(1000, 1000)
    {:ok, game, 10_000}
  end

  def get do
    GenServer.call(:conway_game_server, :get, 1_000)
  end

  def tick do
    GenServer.call(:conway_game_server, :tick, 10_000)
  end

  def handle_call(:get, _from, game) do
    {:reply, game, game}
  end

  def handle_call(:tick, _from, game) do
    game = Game.tick(game)
    {:reply, game, game}
  end
end
