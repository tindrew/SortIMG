defmodule Sortimg do
  def get_files(directory) do
    files_and_directories = File.ls!(directory)

    {directories, files} =
      Enum.split_with(files_and_directories, fn file_or_directory ->
        File.dir?(file_or_directory)
      end)

    ### what do we want to return?
    Enum.map(files, fn file -> Path.join(directory, file) end) ++
      Enum.map(
        Enum.flat_map(directories, fn directory -> get_files(directory) end),
        fn subpath -> Path.join(directory, subpath) end
      )
  end

  def identify_files(files) do
    Enum.filter(files, fn file -> is_file_jpeg?(file) end)
  end

  def is_file_jpeg?(file) do
    case File.read(file) do
      {:ok, <<0xFF, 0xD8, 0xFF, _::binary>>} -> true
      {:ok, <<0x89, 0x50, 0x4e, 0x47, _::binary>>} -> true
      {:ok, <<0x47, 0x49, 0x46, 0x38, 0x37, 0x61, _::binary>>} -> true
      _ -> false
    end
  end
end

[dir | _] = System.argv()

Sortimg.get_files(dir)
|> Sortimg.identify_files()
|> IO.inspect()
#elixir lib/sortimg.ex .

# elixir lib/sortimg.ex .     -> Output the list of found images
# elixir lib/sortimg.ex -c .  -> Output the count
# Found:
#   JPEGs: ##
#   GIFs:  ##
#   PNGs:  ##
