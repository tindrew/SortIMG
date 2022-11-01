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

    {directories, files} = Enum.split_with(files_and_directories, fn file_or_directory ->
        File.dir?(file_or_directory)
    end)

    ### what do we want to return?
    Enum.map(files, fn file -> Path.join(directory, file) end) ++ Enum.flat_map(directories, fn directory -> get_files(directory) end)

  end

end

[dir | _] = System.argv()

Sortimg.get_files(dir)
|> IO.inspect()
