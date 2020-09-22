defmodule ParseTest do
  use ExUnit.Case
  import Climate.Parse

  test "returns parse xml" do
    assert parse_xml("<foo>bar</foo>") == ['bar']
  end

  test "raises error when input is not binary" do
    assert_raise RuntimeError, fn -> parse_xml(:foo) end
  end
end
