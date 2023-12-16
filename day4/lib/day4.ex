defmodule Day4 do
  #Grab input from file and split lines.
  def input do
    {:ok, i} = File.read("lib/input.tx")
    String.trim_trailing(i)
    |> String.split("\n")
    |> Enum.map(fn string -> String.split(string, ": ") end)
    |> IO.inspect()
    |> Enum.map(fn [_game, ints] -> ints end)
    |> Enum.map(&String.split(&1, " | "))
    |> Enum.map(fn [winners, nums] ->
      [String.split(winners), String.split(nums)] end)
  end

  
  
end
