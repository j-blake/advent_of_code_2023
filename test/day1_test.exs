defmodule Day1Test do
  use ExUnit.Case
  alias Day1

  test "it parses number only string" do
    assert Day1.sum_calibration_values("day1/sample.txt") === 142
  end
end
