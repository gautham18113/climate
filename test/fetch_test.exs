defmodule FetchTest do
  use ExUnit.Case
  import Mock
  import Climate.Fetch


  test "raises error on invalid response" do
    with_mock HTTPoison,
    [
      get: fn("https://w1.weather.gov/xml/current_obs/foo.xml", _) ->
        {:ok, %{body: "Invalid Request", status_code: 403}}
    end
    ] do
      assert_raise RuntimeError, fn -> fetch("foo") end
    end
  end

  test "returns body on successful response" do
    with_mock HTTPoison,
    [
      get: fn("https://w1.weather.gov/xml/current_obs/foo.xml", _) ->
        {:ok, %{body: "Success!", status_code: 200}}
    end
    ] do
      assert fetch("foo") == "Success!"
    end
  end
end
