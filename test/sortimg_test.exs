defmodule SortimgTest do
  use ExUnit.Case
  doctest Sortimg

  test "should get files" do
    assert Sortimg.get_files("./test") == "sortimg_test.exs", "test_helper.exs"
  end
end
