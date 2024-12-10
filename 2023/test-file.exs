file_path = "./inputday02.txt"

{:ok, content} = File.read(file_path)
result = String.split(content, "\n")
Enum.map(result, fn line -> IO.inspect(line) end)
