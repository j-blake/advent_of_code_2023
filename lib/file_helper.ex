defmodule FileHelper do
  @moduledoc """
  reads file and splits by newline
  """

  @doc """
  Read a file and split it by blank lines.
  """
  @spec read_file(String.t()) :: [String.t()]
  def read_file(path) do
    Path.join([__DIR__, "advent_of_code2023", path])
    |> File.read!()
    |> String.split("\n")
  end
end
