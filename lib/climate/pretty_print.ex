defmodule Climate.PrettyPrint do
  def pprint(map) do
    map
    |> print()
  end

  defp print(map) do
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
