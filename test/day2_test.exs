defmodule Day2Test do
  use ExUnit.Case
  alias Day2

  test "it sums the IDs of possible games" do
    assert Day2.part_1() === 8
  end

  test "it sums IDs of puzzle input" do
    assert Day2.part_1("day2/input.txt") === 2204
  end

  test "it sums minimum set of cubes" do
    assert Day2.part_2() === 2286
  end

  test "it sums minimum set of cubes of puzzle input" do
    assert Day2.part_2("day2/input.txt") === 71036
  end
end
