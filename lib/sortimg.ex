defmodule Sortimg do
  @moduledoc """
  Documentation for `Sortimg`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Sortimg.hello()
      :world

  """
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
#learn how to open a file
#jpeg's magic number is ff d8 ff
#my assignment pattern matching find_strings_starting_with_fgh = ["fgh", "hgf", "ffe", "tfgh", "fghh", "ffgh"]
#can't use String.starts_with
  end
end

[dir | _] = System.argv()

Sortimg.get_files(dir)
|> IO.inspect()
