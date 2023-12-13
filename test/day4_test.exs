defmodule Day4Test do
  use ExUnit.Case

  doctest Day4

  test "it calculates example input for Part 1" do
    assert Day4.part_1() === 13
  end

  test "it calculates puzzle input for Part 1" do
    assert Day4.part_1("day4/input.txt") === 21213
  end

  test "it calculates example input for Part 2" do
    assert Day4.part_2() === 30
  end

  test "it calculates puzzle input for Part 2" do
    assert Day4.part_2("day4/input.txt") === 8549735
  end
end
