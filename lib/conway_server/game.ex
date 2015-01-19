defmodule ConwayServer.Game do
  defstruct width: -1, height: -1, cells: []

  def random(width, height) do
    new_board(width, height, random_points(width, height))
  end

  def random_points(width, height) do
    zipped = for x <- (0..width-1), y <- (0..height-1), do: {x, y}

    zipped
      |> Enum.map(fn(pos) -> {pos, spawn_rate} end)
      |> Enum.filter(fn({_pos, alive}) -> alive end)
  end

  defp spawn_rate(percent \\ 0.05) do
    :random.uniform <= percent
  end

  def new(width, height, points \\ []) do
    cells = points |> Enum.map(&{&1, true})
    new_board(width, height, cells)
  end

  defp new_board(width, height, cells) do
    %ConwayServer.Game{
      width:  width,
      height: height,
      cells:  build_cells(cells)
    }
  end

  def tick(game = %ConwayServer.Game{}) do
    %ConwayServer.Game{game | cells: build_next_cells(game)}
  end

  defp build_cells(points) do
    for {coordinate, true} <- points,
      into: HashSet.new,
      do:   coordinate
  end

  defp build_next_cells(game) do
    alive_plus_neighbors(game.cells)
      |> Stream.map(&{&1, next_cell_status(game.cells, &1)})
      |> build_cells
  end

  def cell_at(cells, x, y) do
    cell_at(cells, {x, y})
  end

  def cell_at(cells, pos) do
    HashSet.member?(cells, pos)
  end

  def to_map(game) do
    data = %{
      width: game.width,
      height: game.height,
      cells:  Enum.map(game.cells, fn({x, y}) -> [x, y] end),
    }
  end

  defp alive_plus_neighbors(cells) do
    cells
      |> Enum.flat_map(&[&1 | neighbors(&1)])
      |> Enum.into(HashSet.new)
  end

  defp neighbors({cell_x, cell_y}) do
   for x <- (cell_x - 1)..(cell_x + 1),
       y <- (cell_y - 1)..(cell_y + 1),
       (x != cell_x or y != cell_y),
      do: {x, y}
  end

  defp alive_neighbors(cells, pos) do
    neighbors(pos)
      |> Enum.map(fn {x, y} -> if cell_at(cells, x, y), do: 1, else: 0 end)
      |> Enum.sum
  end

  defp next_cell_status(cells, pos) do
    alive     = cell_at(cells, pos)
    neighbors = alive_neighbors(cells, pos)

    case {alive, neighbors} do
      {true, 2}  -> true
      {true, 3}  -> true
      {false, 3} -> true
      {_, _}     -> false
    end
  end
end
