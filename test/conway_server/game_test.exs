defmodule ConwayServer.GameTest do
  use ExUnit.Case

  alias ConwayServer.Game

  test "initial board" do
    game = Game.new(3, 3, [{1,1}, {1,2}])
    cell = game.cells
      |> Game.cell_status({1,1})

    assert cell == 1
  end

  test "random board" do
    game = Game.random(3, 3)

    assert game.width == 3
    assert game.height == 3
  end

  test "an alive cell with 1 neighbors, dies" do
    game = Game.new(3, 3, [{1,1}, {1,2}])
      |> Game.tick

    cell = game.cells
      |> Game.cell_status({1,1})

    assert cell == 0
  end

  test "an alive cell with 2 neighbors, lives" do
    game = Game.new(3, 3, [{1, 0}, {1,1}, {1,2}])
      |> Game.tick

    cell = game.cells
      |> Game.cell_status({1,1})

    assert cell == 1
  end

  test "an alive cell with 3 neighbors, lives" do
    game = Game.new(3, 3, [{1, 0}, {1,1}, {1,2}, {2, 1}])
      |> Game.tick

    cell = game.cells
      |> Game.cell_status({1,1})

    assert cell == 1
  end

  test "an alive cell with 4 neighbors, dies" do
    game = Game.new(3, 3, [{1, 0}, {1,1}, {1,2}, {2, 0}, {2, 1}])
      |> Game.tick

    cell = game.cells
      |> Game.cell_status({1,1})

    assert cell == 0
  end

  test "a dead cell with 2 neighbors, stays dead" do
    game = Game.new(3, 3, [{1, 0}, {1,1}])
      |> Game.tick

    cell = game.cells
      |> Game.cell_status({2,1})

    assert cell == 0
  end

  test "a dead cell with 3 neighbors, lives" do
    game = Game.new(3, 3, [{1, 0}, {1,1}, {1,2}])
      |> Game.tick

    cell = game.cells
      |> Game.cell_status({2,1})

    assert cell == 1
  end

  test "a dead cell with 4 neighbors, stays dead" do
    game = Game.new(3, 3, [{1, 0}, {1,1}, {1,2}, {2,0}])
      |> Game.tick

    cell = game.cells
      |> Game.cell_status({2,1})

    assert cell == 0
  end
end

