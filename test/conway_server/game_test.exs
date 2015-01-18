defmodule ConwayServer.GameTest do
  use ExUnit.Case

  alias ConwayServer.Game

  test "a new board" do
    game = Game.new(3, 3)

    assert game.cells == [
      [ %{pos: {0, 0}, alive: false}, %{pos: {0, 1}, alive: false}, %{pos: {0, 2}, alive: false} ],
      [ %{pos: {1, 0}, alive: false}, %{pos: {1, 1}, alive: false}, %{pos: {1, 2}, alive: false} ],
      [ %{pos: {2, 0}, alive: false}, %{pos: {2, 1}, alive: false}, %{pos: {2, 2}, alive: false} ],
    ]
  end

  test "seed a board" do
    game = Game.new(3, 3, [{0,1}, {1,2}, {2,0}])

    assert game.cells == [
      [ %{pos: {0, 0}, alive: false}, %{pos: {0, 1}, alive: true},  %{pos: {0, 2}, alive: false} ],
      [ %{pos: {1, 0}, alive: false}, %{pos: {1, 1}, alive: false}, %{pos: {1, 2}, alive: true} ],
      [ %{pos: {2, 0}, alive: true},  %{pos: {2, 1}, alive: false}, %{pos: {2, 2}, alive: false} ],
    ]
  end

  test "an alive cell with 1 neighbors, dies" do
    game = Game.new(3, 3, [{1,1}, {1,2}])
      |> Game.tick

    cell = game.cells
      |> Game.cell_at(1,1)
   
    assert cell.alive == false
  end

  test "an alive cell with 2 neighbors, lives" do
    game = Game.new(3, 3, [{1, 0}, {1,1}, {1,2}])
      |> Game.tick

    cell = game.cells
      |> Game.cell_at(1,1)

    assert cell.alive == true
  end

  test "an alive cell with 3 neighbors, lives" do
    game = Game.new(3, 3, [{1, 0}, {1,1}, {1,2}, {2, 1}])
      |> Game.tick

    cell = game.cells
      |> Game.cell_at(1,1)

    assert cell.alive == true
  end

  test "an alive cell with 4 neighbors, dies" do
    game = Game.new(3, 3, [{1, 0}, {1,1}, {1,2}, {2, 0}, {2, 1}])
      |> Game.tick

    cell = game.cells
      |> Game.cell_at(1,1)

    assert cell.alive == false
  end

  test "a dead cell with 2 neighbors, stays dead" do
    game = Game.new(3, 3, [{1, 0}, {1,1}])
      |> Game.tick

    cell = game.cells
      |> Game.cell_at(2,1)

    assert cell.alive == false
  end

  test "a dead cell with 3 neighbors, lives" do
    game = Game.new(3, 3, [{1, 0}, {1,1}, {1,2}])
      |> Game.tick

    cell = game.cells
      |> Game.cell_at(2,1)

    assert cell.alive == true
  end

  test "a dead cell with 4 neighbors, stays dead" do
    game = Game.new(3, 3, [{1, 0}, {1,1}, {1,2}, {2,0}])
      |> Game.tick

    cell = game.cells
      |> Game.cell_at(2,1)

    assert cell.alive == false
  end
end

