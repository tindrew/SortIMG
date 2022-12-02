# takes a list and returns number of items in the list
defmodule ListSize do
  def list_size(list) do
    if list == [] do
      0
    else
      1 + list_size(tl(list))
    end
  end

  def list_size_tail(list, size) do
    if list == [] do
      size
    else
      list_size_tail(tl(list), size+1)
    end
  end

end

ListSize.list_size(["a", "b", "c"]) |> IO.puts

ListSize.list_size_tail(["a", "b", "c"], 0) |> IO.puts
