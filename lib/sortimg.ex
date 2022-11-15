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
    # give it a file
    # open file
    # get some bytes from the file (aka: get some of the file as a binary)
    # so, lets get 25

    # check if magic number exists
    # %File.Stream
    #elixir lib/sortimg.ex .
    case File.read(file) do
      {:ok, <<0xFF, 0xD8, 0xFF, _::binary>>} -> true
      _ -> false
    end

#tuples, one as pngs one as jpegs, one as ??

    # https://github.com/ishikawa/elixir-magic-number
    # scan the file, if magic_number == "ff d8 ff"
    # read the file's binary signature?
    # learn how to open a file
    # jpeg's magic number is ff d8 ff
    # my assignment pattern matching find_strings_starting_with_fgh = ["fgh", "hgf", "ffe", "tfgh", "fghh", "ffgh"]
    # can't use String.starts_with
  end
end

[dir | _] = System.argv()

Sortimg.get_files(dir)
|> Sortimg.identify_files()
|> IO.inspect()
