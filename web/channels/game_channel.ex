defmodule ConwayServer.GameChannel do
  use Phoenix.Channel

  def join("game:global", _data, socket) do
    {:ok, socket}
  end
end
