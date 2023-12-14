# 

defmodule Day3 do
  defp grab_input do
    {:ok, input} = File.read("lib/input.txt")
    input
  end

  defp format_input(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn line -> String.graphemes(line)
      |> Enum.with_index(fn elmnt, idx -> {idx, {elmnt, idx}} end)
      |> Map.new()
      end)
    |> Enum.with_index(fn elmnt, idx -> {idx, elmnt} end)
    |> Map.new()
  end

  def print_input() do
    grab_input() |> format_input()
  end
end

