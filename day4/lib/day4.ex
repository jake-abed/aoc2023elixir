defmodule Day4 do
  #Grab input from file and split lines.
  def input do
    {:ok, i} = File.read("lib/input.tx")
    String.trim_trailing(i)
    |> String.split("\n")
    |> Enum.map(fn string -> String.split(string, ": ") end)
    |> Enum.map(fn [_game, ints] -> ints end)
    |> Enum.map(&String.split(&1, " | "))
    |> Enum.map(fn [winners, nums] ->
      [String.split(winners), String.split(nums)] end)
  end

  def filter_guesses(both_sets) do
    [winners, guesses] = both_sets
    Enum.filter(guesses, fn guess -> Enum.any?(winners, fn winner -> guess === winner end) end)
  end

  defp calc_points(count) do
    case count do
      0 -> 0
      1 -> 1
      2 -> 2
      _ -> Integer.pow(2, count - 1)
    end
  end

  def get_answer do
    Day4.input 
    |> Enum.map(&Day4.filter_guesses/1)
    |> Enum.map(fn entry -> length(entry) end)
    |> Enum.map(&calc_points(&1))
    |> Enum.reduce(fn x, acc -> x + acc end)
  end
  
end
