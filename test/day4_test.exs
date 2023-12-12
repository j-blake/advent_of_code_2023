defmodule Day4Test do
  use ExUnit.Case

  test "it calculates example input for Part 1" do
    assert Day4.part_1() === 13
  end

  test "it calculates puzzle input for Part 1" do
    assert Day4.part_1("day4/input.txt") === 21213
  end
end
