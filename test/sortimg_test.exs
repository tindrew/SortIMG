defmodule SortimgTest do
  use ExUnit.Case
  doctest Sortimg

  test "should get files" do
    assert Sortimg.get_files("./test") == ["test_helper.exs", "sortimg_test.exs"]
  end
end
