defmodule Climate.Cli do

  alias Climate.Fetch
  alias Climate.Parse
  alias Climate.Transform
  alias Climate.PrettyPrint

  @moduledoc """
  The CLI interface to interact with https://w1.weather.gov/ to fetch climate related
  information in specific airport locations.

  The CLI allows to pass in a location which is an airport code like KDNA and
  a table summarizing the information extracted will be printed.
  """

  @spec main([binary]) :: binary()
  @doc """
  The entrypoint method, takes a list of strings passed as arguments to the cli and chooses
  appropriate methods to pass.
  """
  def main(argv) do
    argv
    |> cli_parser()
    |> entry_point()
  end

  defp cli_parser(argv) do
    OptionParser.parse(argv,
      switches: [help: :boolean, list_locations:  :boolean, location: :string],
      aliases:  [h:       :help, ls:       :list_locations, l:      :location]
    )
    |> options_handler()
  end

  defp entry_point({:ok, :help}), do: :help

  defp entry_point({:error, :invalid}) do
    "The commands don't look right, please use --help to get the correct usage"
  end

  defp entry_point({:ok, location}) do
    location
    |> Fetch.fetch()
    |> Parse.parse_xml()
    |> Transform.transform()
    |> Map.take([:weather, :temperature_string, :location])
    |> PrettyPrint.pprint()
  end

  defp options_handler({[help: true], [], []}) do
    {:ok, :help}
  end

  defp options_handler({[location: loc], [], []}) do
    {:ok, loc}
  end

  defp options_handler(_) do
    {:error, :invalid}
  end

end
