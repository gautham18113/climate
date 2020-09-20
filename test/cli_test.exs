defmodule ClimateCliTest do
  use ExUnit.Case
  doctest Climate.Cli

  test "shows help when --help is given" do
    assert Climate.Cli.main(["--help"]) == :help
  end

  test "returns help message on unmatched args" do
    assert Climate.Cli.main(["--something"]) == "The commands don't look right, please use --help to get the correct usage"
  end
end
