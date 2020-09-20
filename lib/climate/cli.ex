defmodule Climate.Cli do

  alias Climate.Fetch
  alias Climate.Parse
  alias Climate.Transform
  alias Climate.PrettyPrint

  @moduledoc """
  The CLI interface to interact with https://w1.weather.gov/ to fetch climate related
  information in specific airport airport_codes.

  The CLI allows to pass in a airport_code which is an airport code like KDNA and
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
      switches: [
        help:                 :boolean,
        list_airport_codes:   :boolean,
        search_airport_codes: :string,
        airport_code:         :string,
      ],
      aliases: [
        h:      :help,
        lsc:    :list_airport_codes,
        search: :search_airport_codes,
        c:      :airport_code]
    )
    |> options_handler()
  end

  defp entry_point({:ok, :help}), do: :help

  defp entry_point({:error, :invalid}) do
    "The commands don't look right, please use --help to get the correct usage"
  end

  defp entry_point({:ok, airport_code}) do
    airport_code
    |> Fetch.fetch()
    |> Parse.parse_xml()
    |> Transform.transform()
    |> Map.take([:weather, :temperature_string, :airport_code])
    |> PrettyPrint.pprint()
  end

  defp options_handler({[help: true], [], []}) do
    {:ok, :help}
  end

  defp options_handler({[airport_code: loc], [], []}) do
    {:ok, loc}
  end

  defp options_handler(_) do
    {:error, :invalid}
  end

end
