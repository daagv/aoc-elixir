# input: a file containig the following format -> Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
# output: sum of all possible game IDs

# 1. Define a list as module attribute with the given configuration
# 1. Read the file
# 2. Process the file
  # 2.1 Split for each line on delimiter : and
# 3. Map the input into a map with the following structure %{integer => [[set1], [set2], ...], integer2 => [[set1, ...]]}
# 4. After having a full map, i am going to check each set of each game id with the configuration, if each number off
# every set is <= to the configuration, then the game is possible, for which i will have a list to append it and later get its total sum

defmodule Aoc.Day02 do

  @configuration %{"red" => 12, "green" => 13, "blue" => 14}

  def part1(input) do
    input
    |>process_input()

  end

  @spec process_input(String.t()) :: map()
  defp process_input(input) do
    [head|tail] = String.split(input, ":", trim: true)
    values = List.to_string(tail) |> String.split(";", trim: true)
    map_content = [head] ++ [values]
    chunked_list = Enum.chunk_every(map_content,2)
    final_map = Map.new(chunked_list, fn [k, v] -> {k, v} end)
  end

  # %{"Game 3" => [" 8 green, 6 blue, 20 red", " 5 blue, 4 red, 13 green", " 5 green, 1 red"]}
  # returns : [" 8 green", " 6 blue", " 20 red", " 5 blue", " 4 red", " 13 green", " 5 green", " 1 red"]
  defp process_map(map) do
    keys = Map.keys(map)
    # returns : [" 8 green", " 6 blue", " 20 red", " 5 blue", " 4 red", " 13 green", " 5 green", " 1 red"]
    results_per_game = Enum.map(map, fn {_game, list} -> Enum.map(list, fn item -> String.split(item, ",", trim: true) end) end) |> List.flatten()

  end

end
