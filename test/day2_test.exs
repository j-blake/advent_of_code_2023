defmodule Day2Test do
  use ExUnit.Case
  alias Day2

  test "it sums the IDs of possible games" do
    assert Day2.part_1() === 8
  end
end
