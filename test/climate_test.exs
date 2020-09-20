defmodule ClimateTest do
  use ExUnit.Case
  doctest Climate

  test "greets the world" do
    assert Climate.hello() == :world
  end
end
