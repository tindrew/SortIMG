defmodule MakeAs do
  def make_as(num_of_as) do
    cond do
      num_of_as == 1 -> "a"
      true -> "a" <> make_as(num_of_as - 1)
    end
  end

  # tail recursion
  def make_as_tail(num_of_as, answer) do
    if num_of_as == 0 do
      answer
    else
      make_as_tail(num_of_as-1, answer <> "a")
    end
  end



end
MakeAs.make_as(1) |> IO.puts
MakeAs.make_as(2) |> IO.puts
MakeAs.make_as(10) |> IO.puts
MakeAs.make_as_tail(11, "") |> IO.puts

# make_as(2) -> "a" <> make_as(1) -> "a" <> "a" -> "aa"
