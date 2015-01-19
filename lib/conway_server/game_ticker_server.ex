defmodule ConwayServer.GameTickerServer do
  use GenServer

  alias ConwayServer.GameServer

  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: :conway_game_ticker_server)
  end

  def init(_state) do
    :erlang.send_after(1000, self, :tick)
    {:ok, _state}
  end

  def handle_info(:tick, _state) do
    GameServer.tick
    :erlang.send_after(1000, self, :tick)
    {:noreply, _state}
  end
end
