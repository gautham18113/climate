defmodule PrettyPrintTest do
  use ExUnit.Case
  import Climate.PrettyPrint
  import ExUnit.CaptureIO

  doctest Climate.PrettyPrint

  test "works the right way" do
    assert capture_io(fn -> pprint(%{foo: "foo", bar: "bar"}) end) == "bar: bar\nfoo: foo\n"
  end

  test "works when the key is binary" do
    assert capture_io(fn -> pprint(%{"foo": "foo", "bar": "bar"}) end) == "bar: bar\nfoo: foo\n"
  end

end
