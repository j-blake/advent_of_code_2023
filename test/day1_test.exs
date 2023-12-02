defmodule Day1Test do
  use ExUnit.Case
  alias Day1

  test "it parses number only string" do
    assert Day1.sum_calibration_values("day1/sample.txt") === 142
  end

  test "it parses numbers written as words" do
    assert Day1.sum_calibration_values("day1/sample2.txt") === 281
  end

  test "it parses overlapping numbers written as words" do
    assert Day1.sum_calibration_values("../test/day1/input.txt") === 214
  end

  test "it parses the test input" do
    assert Day1.sum_calibration_values("day1/input.txt") === 55429
  end
end
