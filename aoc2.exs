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
    String.split(input, "\n", trim: true)
    |> process_input()
    |> process_map()

  end

  # returns : %{1 => [" 3 blue", " 4 red", " 1 red", " 2 green", " 6 blue", " 2 green"]}
  @spec process_input(String.t()) :: map()
  defp process_input(input) do
    [head|tail] = String.split(input, ":", trim: true)
    values = List.to_string(tail) |> String.split(";", trim: true)
    processed_values = Enum.map(values, fn item ->
      String.split(item, ",", trim: true) end)
      |> List.flatten()
    game_number = String.split(head, " ", trim: true) |> List.last() |> String.to_integer()
    map_content = [game_number] ++ [processed_values]
    chunked_list = Enum.chunk_every(map_content,2)
    Map.new(chunked_list, fn [k, v] -> {k, v} end)
  end

  defp process_map(map) do
    results_per_game = Enum.map(map, fn {game, list} ->
    Enum.map(list, fn result ->
      [number|color] = String.split(result, " ", trim: true)
      [{String.to_integer(number),color}]
    end)
    |> List.flatten()
  end)
  end

end

file_path = "./inputday02.txt"

case File.read(file_path) do
  {:ok, content} ->
    result = Aoc.Day02.part1(content)
    IO.puts(result)

    {:error, reason} -> IO.puts("Failed to read de file: #{reason}")
end
