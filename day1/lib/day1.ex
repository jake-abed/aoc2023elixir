defmodule Day1 do
  require File

  defp input do
    {:ok, input} = File.read('lib/day.txt')
    input
  end

  def filter_digits2(<<>>), do: <<>>
  def filter_digits2(<<x, rest::binary>>) when x in ?1..?9, do: <<x>> <> filter_digits2(rest)
  def filter_digits2(<<"one", rest::binary>>), do: "1" <> filter_digits2("e" <> rest)
  def filter_digits2(<<"two", rest::binary>>), do: "2" <> filter_digits2("o" <> rest)
  def filter_digits2(<<"three", rest::binary>>), do: "3" <> filter_digits2("e" <> rest)
  def filter_digits2(<<"four", rest::binary>>), do: "4" <> filter_digits2(rest)
  def filter_digits2(<<"five", rest::binary>>), do: "5" <> filter_digits2("e" <> rest)
  def filter_digits2(<<"six", rest::binary>>), do: "6" <> filter_digits2(rest)
  def filter_digits2(<<"seven", rest::binary>>), do: "7" <> filter_digits2("n" <> rest)
  def filter_digits2(<<"eight", rest::binary>>), do: "8" <> filter_digits2("t" <> rest)
  def filter_digits2(<<"nine", rest::binary>>), do: "9" <> filter_digits2("e" <> rest)
  def filter_digits2(<<_, rest::binary>>), do: filter_digits2(rest)

  defp convertInputToList do
    String.split(input(), "\n")
  end

  defp removeAlphas string do
    String.replace(string, ~r/[a-zA-Z]*/, "")
  end

  defp getFLInt string do
    result = String.to_integer(String.first(string) <> String.last(string))
    IO.inspect(result)
    result
  end

  defp convertListToStrings (codes) do
    list = Enum.map(codes, fn x -> filter_digits2(x) |> getFLInt() end)
    list
  end

  def returnCodeSum do
    list = convertInputToList() |> convertListToStrings()
    Enum.sum(list)
  end
end
