defmodule Day3Test do
  use ExUnit.Case

  test "it calculates example input" do
    assert Day3.part_1() === 4361
  end

  test "it calculates puzzle input" do
    assert Day3.part_1("day3/input.txt") === 520135
  end
end
