defmodule Climate.PrettyPrint do
  @moduledoc """
  Takes a map and pretty prints it into the console.
  Currently limited to print the map as evenly spaced key
  value pairs. Can be extended to provide other modes of
  pretty print like pretty print to table for example.
  """
  require Logger

  @doc """
  Takes a map and prints it in a pretty format
  """
  def pprint(map) do

    Logger.debug "Pretty Print received map
    #{Enum.map_join(map, ", ", fn {key, val} -> ~s{"#{key}", "#{val}"} end)}"

    max_col_width = Map.keys(map)
                    |> Enum.map(&Atom.to_string/1)
                    |> Enum.map(&String.length/1)
                    |> Enum.reduce(&max/2)
    map
    |> Enum.each(fn({k, v}) -> IO.puts "#{format_key(k, max_col_width)}: #{format_val(v)}" end)
  end


  defp format_key(k, mx_len) do
    k
    |> Atom.to_string()
    |> String.pad_trailing(mx_len)
  end

  defp format_val(v) do
    v
  end
end
