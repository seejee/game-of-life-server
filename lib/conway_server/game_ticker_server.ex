defmodule ConwayServer.GameTickerServer do
  use GenServer

  alias ConwayServer.Game
  alias ConwayServer.GameServer

  @timeout 100

  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: :conway_game_ticker_server)
  end

  def init(_state) do
    :erlang.send_after(@timeout, self, :tick)
    {:ok, _state}
  end

  def handle_info(:tick, _state) do
    GameServer.tick |> broadcast
    :erlang.send_after(@timeout, self, :tick)
    {:noreply, _state}
  end

  def broadcast(game = %Game{}) do
    Phoenix.Channel.broadcast "game:global", "game:data", Game.to_map(game)
  end
end
