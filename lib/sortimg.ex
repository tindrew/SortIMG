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
    File.ls!(directory)
  end

end
