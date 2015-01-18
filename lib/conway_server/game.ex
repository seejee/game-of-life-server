defmodule ConwayServer.Game do
  defstruct width: -1, height: -1, cells: []

  def new(width, height, points \\ []) do
    %{
      width:  width,
      height: height,
      cells:  build_cells(width, height, points)
    }
  end

  def tick(game) do
    cells = build_next_cells(game)
    %{game | cells: cells}
  end

  defp build_cells(width, height, points) do
    Enum.map(0..width-1, fn x ->
      Enum.map(0..height-1, fn y ->
        alive = Enum.member?(points, {x, y})
        %{pos: {x, y}, alive: alive}
      end)
    end)
  end

  defp build_next_cells(game) do
    Enum.map(0..game.width-1, fn x ->
      Enum.map(0..game.height-1, fn y ->
        cell      = cell_at(game.cells, x, y)
        neighbors = alive_neighbors(game.cells, x, y)
        alive     = alive_next?(cell.alive, neighbors)

        %{pos: {x, y}, alive: alive}
      end)
    end)
  end

  def cell_at(cells, x, y) do
    row = Enum.at(cells, x)

    if row do
      Enum.at(row, y)
    end
  end

  defp alive_neighbors(cells, x, y) do
    Enum.reduce(x - 1..x + 1, 0, fn(x_cell, acc) ->
      Enum.reduce(y - 1..y + 1, acc, fn(y_cell, acc) ->
        cell = cell_at(cells, x_cell, y_cell)

        if cell && (cell.pos != {x, y}) && cell.alive do
          acc + 1
        else
          acc
        end
      end)
    end)
  end

  defp alive_next?(true, 2), do: true
  defp alive_next?(true, 3), do: true
  defp alive_next?(false, 3), do: true
  defp alive_next?(alive, neighbors) do
    false
  end
end
