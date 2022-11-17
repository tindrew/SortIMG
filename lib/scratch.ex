defmodule Journal do
  @moduledoc """
  Documentation for `Journal`
  """
  use Agent

  @doc """
  Start the Agent process.

  ## Examples

      Default.

      iex> {:ok, pid} = Journal.start_link([])

      With initial entries.

      iex> {:ok, pid} = Journal.start_link(entries: ["Entry1", "Entry 2"])
  """
  def start_link(opts), do: Agent.start_link(fn -> opts end)

  @doc """
  Get all journal entries.

  ## Examples

      Empty journal.

      iex> {:ok, pid} = Journal.start_link([])
      iex> Journal.all_entries(pid)
      []

      Journal with entries. Entries are returned in ascending order (oldest entries first).

      iex> {:ok, pid} = Journal.start_link(["Entry 1", "Entry 2"])
      iex> Journal.all_entries(pid)
      ["Entry 1", "Entry 2"]

      Ascending order (default).

      iex> {:ok, pid} = Journal.start_link(["Entry 1", "Entry 2"])
      iex> Journal.all_entries(pid, order: :asc)
      ["Entry 1", "Entry 2"]

      Descending order.

      iex> {:ok, pid} = Journal.start_link(["Entry 1", "Entry 2"])
      iex> Journal.all_entries(pid, order: :desc)
      ["Entry 2", "Entry 1"]
  """
  def all_entries(pid, opts \\ []) do

    order = Keyword.get(opts, :order)

    Agent.get(pid, fn state ->
      if order == :desc do
        Enum.reverse(state)
      else
        state
      end
    end)
  end



  @doc """
  Add a journal entry.

  ## Examples

    iex> {:ok, pid} = Journal.start_link([])
    iex> Journal.add_entry(pid, "Entry 1")
    :ok
    iex> Journal.add_entry(pid, "Entry 2")
    :ok
    iex> Journal.all_entries(pid)
    ["Entry 1", "Entry 2"]
  """
  def add_entry(pid, entry) do
    Agent.update(pid, fn state ->
      [entry | state]
      |> Enum.reverse()


       end)
  end
end

{:ok, pid} = Journal.start_link([])
Journal.add_entry(pid, "Entry 1")
Journal.add_entry(pid, "Entry 2")
Journal.all_entries(pid)


#stick to the docs abdullah needs to guide us based on the docs. "What's your input,
#what's your output?" and guide us from there, small pointers of things we can explore
#Come up with protocal, if brook is in the room, abdullah needs to shadow. If it's reversed,
#and abdullah is there first, brook shadow/observe and only intervene if needed
#no two people throwing peanuts at same time
#
