defmodule ConwayServer.PageController do
  use ConwayServer.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
