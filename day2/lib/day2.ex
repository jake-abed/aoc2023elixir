defmodule Day2 do
  require File

  @color_vals %{:blue => 14, :red => 12, :green => 13}

  defp parseInput do
    {:ok, input} = File.read("lib/input.txt")
    input
  end

  defp parseGame(game) do
    [count | gt] = String.split(game, " ")
    color = String.to_atom(hd(gt))
    if String.to_integer(count) <= Map.get(@color_vals, color) do
      true
    else
    false
    end
  end

  defp formatGames(games) do
    List.flatten(Enum.map(games, fn game -> parseGame(game) end))
  end

  defp convertLineToList("") do
    [0, false]
  end

  defp convertLineToList(line) do
    [head | tail] = String.split(line, ": ")
    gameInt = String.replace(head, "Game ", "") |> String.to_integer()
    games = String.split(List.to_string(tail), "; ")
    [gameInt, Enum.map(games,
      fn game -> formatGames(String.split(game,
      ", "))
      end)]
  end

  defp formatInput(input) do
    list = String.split(input, "\n")
    Enum.map(list, fn line -> List.flatten(convertLineToList(line)) end)
  end

  def showFormattedInput do
    formatInput(parseInput())
  end

  def calculateGameSum do
    parsedInput = formatInput(parseInput())
    realGames = Enum.map(parsedInput,
      fn game ->
        [score | tail] = game
        if Enum.all?(tail) do
          score
        else 0
      end
    end)
    Enum.reduce(realGames, fn x, acc -> x + acc end)
  end
end

