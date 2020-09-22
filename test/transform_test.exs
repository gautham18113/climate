defmodule TransformTest do
  use ExUnit.Case
  import Climate.Transform

  doctest Climate.Transform

  test "returns a map with empty values when a erlsom simple form is provided with charlist value" do
    assert transform([{'key1',[], 'val1'}, {'key2', [], 'val2'}]) ==  %{key1: "", key2: ""}
  end

  test "returns a map with values when a erlsom simple form is provided with normal list value" do
    assert transform([{'key1',[], ['val1']}, {'key2', [], ['val2']}]) ==  %{key1: "val1", key2: "val2"}
  end

  test "raises error when the format is not erlsom simple form" do
    assert_raise(RuntimeError, fn -> transform("") end)
  end

end
