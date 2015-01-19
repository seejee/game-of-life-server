defmodule ConwayServer.Game do
  import ExProf.Macro

  defstruct width: -1, height: -1, cells: []

  def random(width, height) do
    new(width, height, random_points(width, height))
  end

  def random_points(width, height) do
    zipped = for x <- (0..width-1), y <- (0..height-1), do: {x, y}

    zipped
      |> Enum.map(fn(pos) -> {pos, spawn_rate} end)
      |> Enum.filter(fn({_pos, alive}) -> alive end)
      |> Enum.map(fn({pos, _alive}) -> pos end)
  end

  defp spawn_rate(percent \\ 0.075) do
    :random.uniform <= percent
  end

  def new(width, height, points \\ []) do
    %ConwayServer.Game{
      width:  width,
      height: height,
      cells:  points |> Enum.into(HashSet.new)
    }
  end

  def tick(game = %ConwayServer.Game{}) do
    %ConwayServer.Game{game | cells: build_next_cells(game)}
  end

  defp build_next_cells(game) do
    alive_plus_neighbors(game.cells)
      |> Enum.reduce(HashSet.new, fn(pos, set) ->
        case next_cell_status(game.cells, pos) do
          true  -> Set.put(set, pos)
          false -> set
        end
      end)
  end

  def cell_status(cells, pos) do
    if Set.member?(cells, pos), do: 1, else: 0
  end

  def to_map(game = %ConwayServer.Game{}) do
    %{
      width:  game.width,
      height: game.height,
      cells:  Enum.map(game.cells, fn({x, y}) -> [x, y] end)
    }
  end

  def alive_plus_neighbors(cells) do
    cells
      |> Enum.flat_map(&neighbors(&1))
      |> Enum.into(HashSet.new)
      |> Set.union(cells)
  end

  def profile_tick(game) do
    profile do
      tick(game)
    end
  end

  defp neighbors({cell_x, cell_y}) do
    [
      { cell_x - 1, cell_y - 1 },
      { cell_x - 1, cell_y     },
      { cell_x - 1, cell_y + 1 },
      { cell_x,     cell_y - 1 },
      { cell_x,     cell_y + 1 },
      { cell_x + 1, cell_y - 1 },
      { cell_x + 1, cell_y     },
      { cell_x + 1, cell_y + 1 },
    ]
  end

  defp alive_neighbors(cells, pos) do
    neighbors(pos)
      |> Enum.reduce(0, fn(coord, acc) ->
        acc + cell_status(cells, coord)
      end)
  end

  defp next_cell_status(cells, pos) do
    alive     = cell_status(cells, pos)
    neighbors = alive_neighbors(cells, pos)

    case {alive, neighbors} do
      {1, 2} -> true
      {_, 3} -> true
      {_, _} -> false
    end
  end
end
