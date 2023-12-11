defmodule Day3Test do
  use ExUnit.Case

  test "it calculates example input for Part 1" do
    assert Day3.part_1() === 4361
  end

  test "it calculates puzzle input for Part 1" do
    assert Day3.part_1("day3/input.txt") === 520135
  end

  test "it calculates example input for Par 2" do
    assert Day3.part_2() === 467835
  end

  test "it calculates puzzle input for Part 2" do
    assert Day3.part_2("day3/input.txt") === 72514855
  end
end
