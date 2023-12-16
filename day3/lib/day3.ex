# 

defmodule Day3 do
  defp grab_input do
    {:ok, input} = File.read("lib/input.txt")
    input
  end

  defp is_part?(grapheme) do
    not String.match?(grapheme, ~r/[.0123456789]/)
  end

  defp tupled_input(input) do
    indexElement = &{&2, &1}
    input
    |> String.split("\n")
    |> Enum.map(fn line -> String.graphemes(line)
      |> Enum.with_index(indexElement)
      end)
    |> Enum.with_index(indexElement)
  end

  def fmt_input do
    grab_input() |> tupled_input()
  end

  def make_part_map(input) do
    input
    |> Enum.map(fn {y, row} ->
      {y, Enum.map(row, fn {x, grapheme} ->
        {x, is_part?(grapheme)}
        end)
      |> Map.new()}
      end)
    |> Map.new()
  end

  defp is_num?(grapheme), do: String.match?(grapheme, ~r/\d/)

  def filter_line_to_nums(line), do: Enum.filter(line, &is_num?(elem(&1, 1)))

  def group_ints(just_nums) do
    chunk_fun = fn elmnt, acc ->
      {x, _num} = elmnt
      if (acc === []) do
        {:cont, [elmnt | acc]}
      else
        if (x - elem(hd(acc),0) !== 1) do
        {:cont, Enum.reverse(acc), [elmnt]}
        else
        {:cont, [elmnt | acc]}
        end
      end  
    end
      
    after_fun = fn
      [] -> {:cont, []}
      acc -> {:cont, Enum.reverse(acc), []}
    end

    just_nums
    |> Enum.chunk_while([], chunk_fun, after_fun)
  end

  defp format_zipped_num entry do
    [x_coords, nums] = entry
    compressed = String.to_integer(List.to_string(Tuple.to_list(nums)))
    [Tuple.to_list(x_coords), compressed]
  end

  defp zip_to_int(grouped_ints) do
    grouped_ints
    |> Enum.map(&Tuple.to_list(&1))
    |> Enum.map(fn [int, string] -> [Integer.to_string(int), string] end)
    |> Enum.zip()
    |> format_zipped_num
  end

  def lines_of_numbers do
    input = Day3.fmt_input
    input
    |> Enum.map(fn {_line_num, line} -> Day3.filter_line_to_nums(line) end)
    |> Enum.map(&Day3.group_ints(&1))
    |> Enum.map(&Enum.map(&1, fn nums -> zip_to_int(nums) end))
  end

end

