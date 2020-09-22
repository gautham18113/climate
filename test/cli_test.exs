defmodule ClimateCliTest do
  use ExUnit.Case
  import Climate.Cli
  import ExUnit.CaptureIO
  import Mock

  test "shows help when --help is given" do
    assert main(["--help"]) == :help
  end

  test "returns help message on unmatched args" do
    assert main(["--something"]) == "The commands don't look right, please use --help to get the correct usage"
  end

  test "shows airport code switch help when  requested" do

    assert capture_io(
      fn -> main(["--airport-code", "--help"]) end) == "
    Accepts an airport code for which climate details
    need to be fetched.
      Usage: climate --airport-code <airport code>
      Ex   : climate --airport-code KDAL
    \n"
  end

  test "returns airport climate information" do
    with_mock HTTPoison,
      [
        get: fn("https://w1.weather.gov/xml/current_obs/FOO.xml", _) ->
          {:ok, %HTTPoison.Response{
            body: "<foo><baz>content</baz><spaz>content</spaz></foo>",
            status_code: 200
          }}
        end
      ] do
        assert capture_io(fn -> main(["--airport-code", "FOO"]) end) == "baz : content\nspaz: content\n"
      end
  end
end
