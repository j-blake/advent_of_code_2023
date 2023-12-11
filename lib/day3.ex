defmodule Day3 do
  @moduledoc """
  ## --- Day 3: Gear Ratios ---

  You and the Elf eventually reach a gondola lift station; he says the gondola lift will take you up to the water
  source, but this is as far as he can bring you. You go inside.

  It doesn't take long to find the gondolas, but there seems to be a problem: they're not moving.

  "Aaah!"

  You turn around to see a slightly-greasy Elf with a wrench and a look of surprise. "Sorry, I wasn't expecting anyone!
  The gondola lift isn't working right now; it'll still be a while before I can fix it." You offer to help.

  The engineer explains that an engine part seems to be missing from the engine, but nobody can figure out which one. If
  you can add up all the part numbers in the engine schematic, it should be easy to work out which part is missing.

  The engine schematic (your puzzle input) consists of a visual representation of the engine. There are lots of numbers
  and symbols you don't really understand, but apparently any number adjacent to a symbol, even diagonally, is a "part
  number" and should be included in your sum. (Periods (.) do not count as a symbol.)

  Here is an example engine schematic:

  ```
  467..114..
  ...*......
  ..35..633.
  ......#...
  617*......
  .....+.58.
  ..592.....
  ......755.
  ...$.*....
  .664.598..
  ```

  In this schematic, two numbers are not part numbers because they are not adjacent to a symbol: 114 (top right) and 58
  (middle right). Every other number is adjacent to a symbol and so is a part number; their sum is 4361.

  Of course, the actual engine schematic is much larger. What is the sum of all of the part numbers in the engine
  schematic?

  Your puzzle answer was 520135.

  ## --- Part Two ---

  The engineer finds the missing part and installs it in the engine! As the engine springs to life, you jump in the
  closest gondola, finally ready to ascend to the water source.

  You don't seem to be going very fast, though. Maybe something is still wrong? Fortunately, the gondola has a phone
  labeled "help", so you pick it up and the engineer answers.

  Before you can explain the situation, she suggests that you look out the window. There stands the engineer, holding a
  phone in one hand and waving with the other. You're going so slowly that you haven't even left the station. You exit
  the gondola.

  The missing part wasn't the only issue - one of the gears in the engine is wrong. A gear is any * symbol that is
  adjacent to exactly two part numbers. Its gear ratio is the result of multiplying those two numbers together.

  This time, you need to find the gear ratio of every gear and add them all up so that the engineer can figure out which
  gear needs to be replaced.

  Consider the same engine schematic again:

  ```
  467..114..
  ...*......
  ..35..633.
  ......#...
  617*......
  .....+.58.
  ..592.....
  ......755.
  ...$.*....
  .664.598..
  ```

  In this schematic, there are two gears. The first is in the top left; it has part numbers 467 and 35, so its gear
  ratio is 16345. The second gear is in the lower right; its gear ratio is 451490. (The * adjacent to 617 is not a gear
  because it is only adjacent to one part number.) Adding up all of the gear ratios produces 467835.

  What is the sum of all of the gear ratios in your engine schematic?


  """

  def part_1(path \\ "day3/sample.txt") do
    schematic = FileHelper.read_file(path)

    symbols =
      schematic
      |> find_symbol_locations()

    numbers =
      schematic
      |> find_number_locations()

    find_adjacent_numbers(symbols, numbers)
    |> Enum.reduce(MapSet.new(), fn {row_idx, col_idx}, acc ->
      {first_idx, last_idx, number} =
        build_number(Enum.at(schematic, row_idx) |> String.graphemes(), col_idx)

      MapSet.put(acc, {row_idx, first_idx, last_idx, number})
    end)
    |> Enum.map(fn {_, _, _, string_number} -> String.to_integer(string_number) end)
    |> Enum.sum()
  end

  def part_2(path \\ "day3/sample.txt") do
    schematic = FileHelper.read_file(path)

    gears =
      schematic
      |> find_symbol_locations()
      |> Enum.filter(fn {symbol, _coord} -> symbol === "*" end)

    numbers =
      schematic
      |> find_number_locations()

    find_adjacent_numbers_to_gear(gears, numbers)
    |> Enum.map(fn {_, adjacent_number_chars} ->
      adjacent_numbers =
        Enum.map(adjacent_number_chars, fn {row_idx, col_idx} ->
          build_number(Enum.at(schematic, row_idx) |> String.graphemes(), col_idx)
        end)
        |> MapSet.new()

      if MapSet.size(adjacent_numbers) === 2 do
        adjacent_numbers
        |> Enum.map(fn {_, _, string_number} -> String.to_integer(string_number) end)
        |> Enum.product()
      else
        []
      end
    end)
    |> List.flatten()
    |> Enum.sum()
  end

  defp find_symbol_locations(schematic) do
    schematic
    |> Enum.with_index()
    |> Enum.map(fn {row, row_index} ->
      row
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.map(fn {char, char_index} ->
        if :error === Integer.parse(char) && char !== "." do
          {char, {row_index, char_index}}
        else
          nil
        end
      end)
      |> Enum.filter(fn x -> x !== nil end)
    end)
    |> List.flatten()
  end

  defp find_number_locations(schematic) do
    schematic
    |> Enum.with_index()
    |> Enum.map(fn {row, row_index} ->
      row
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.filter(fn {char, _idx} ->
        case Integer.parse(char) do
          :error -> false
          _ -> true
        end
      end)
      |> Enum.map(fn {char, column_index} ->
        {int, _} = Integer.parse(char)
        {int, {row_index, column_index}}
      end)
    end)
    |> List.flatten()
    |> Map.new(fn {num, coords} -> {coords, num} end)
  end

  defp find_adjacent_numbers(symbols, numbers) do
    symbols
    |> Enum.map(&find_adjacent_numbers_to_symbol(&1, numbers))
    |> List.flatten()
  end

  defp find_adjacent_numbers_to_gear(gears, numbers) do
    gears
    |> Enum.map(fn {symbol, coords} ->
      adjacent_numbers = find_adjacent_numbers_to_symbol({symbol, coords}, numbers)
      {coords, adjacent_numbers}
    end)
  end

  defp find_adjacent_numbers_to_symbol({_symbol, {row, col}}, numbers) do
    possible_coords = [
      {row - 1, col - 1},
      {row - 1, col},
      {row - 1, col + 1},
      {row, col - 1},
      {row, col + 1},
      {row + 1, col - 1},
      {row + 1, col},
      {row + 1, col + 1}
    ]

    possible_coords
    |> Enum.map(fn coord ->
      case Map.fetch(numbers, coord) do
        {:ok, _num} -> coord
        _ -> nil
      end
    end)
    |> Enum.filter(fn x -> x !== nil end)
  end

  defp build_number(row, idx) do
    {first_part, first_index} = prepend(row, idx)
    {second_part, second_index} = append(row, idx)
    number = List.to_string(first_part) <> Enum.at(row, idx) <> List.to_string(second_part)
    {first_index, second_index, number}
  end

  defp prepend(row, idx, result \\ []) do
    with char when is_binary(char) <- Enum.at(row, idx - 1),
         {_num, _rem} <- Integer.parse(char) do
      prepend(row, idx - 1, [char | result])
    else
      _ -> {result, idx}
    end
  end

  defp append(row, idx, result \\ []) do
    with char when is_binary(char) <- Enum.at(row, idx + 1),
         {_num, _rem} <- Integer.parse(char) do
      append(row, idx + 1, result ++ [char])
    else
      _ -> {result, idx}
    end
  end
end
