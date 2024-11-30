defmodule Calibration do

   # Second part

   @digit_words %{
    "one" => 1, "two" => 2, "three" => 3, "four" => 4, "five" => 5,
    "six" => 6, "seven"=> 7, "eight" => 8, "nine" => 9
  }

  # First part
  def calculate_sum(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&extract_calibration_value/1)
    |> Enum.sum()
  end

  defp extract_calibration_value(line) do
    first_digit = Regex.run(~r/\d/, line)
    |> List.first()
    |> String.to_integer()

    last_digit = Regex.run(~r/\d(?=[^\d]*$)/, line)
    |> List.first()
    |> String.to_integer()

    first_digit * 10 + last_digit
  end



  def calculate_sum2(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&extract_calibration_value2/1)
    |> Enum.sum()
  end

  defp extract_calibration_value2(line) do
    first_digit = line |> extract_first_digit()
    last_digit = line |> extract_last_digit()
    result = first_digit * 10 + last_digit
    IO.puts("Line: #{line}, First: #{first_digit}, Last: #{last_digit}, Result: #{result}")
    result
  end

  defp extract_first_digit(line) do
    extract_digit(line, ~r/(\d|one|two|three|four|five|six|seven|eight|nine)/, :first)
  end

  defp extract_last_digit(line) do
    extract_digit(line, ~r/(\d|one|two|three|four|five|six|seven|eight|nine)/, :last)
  end

  defp extract_digit(line, regex, position) do
    case Regex.scan(regex, line) do
      [] -> 0
      matches ->
        flattened = List.flatten(matches)
        match = case position do
          :first -> List.first(flattened)
          :last -> List.last(flattened)
        end
        convert_to_digit(match)
    end
  end

  defp convert_to_digit(match) do
    case Integer.parse(match) do
      {num, ""} -> num
      :error -> Map.get(@digit_words, match, 0)
    end
  end

end

file_path = "./input2test.txt"

case File.read(file_path) do
  {:ok, content} ->
    result = Calibration.calculate_sum2(content)
    IO.puts(result)

    {:error, reason} -> IO.puts("Failed to read de file: #{reason}")
end
