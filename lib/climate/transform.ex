defmodule Climate.Transform do
  @moduledoc """
  Transforms the result obtained from parsed XML into a
  dictionary.
  """

  @doc """
  Takes a list with attributes of the form
  [
    {'tag1', _, ['value1']},
    {'tag2', _, ['value2']}
  ]
  and returns a dictionary
  %{
    tag1: 'value1',
    tag2: 'value2'
  }
  ## Example
    iex(1)> Climate.Transform.transform([{'key1',[], 'val1'}, {'key2', [], 'val2'}])
    %{key1: "val1", key2: "val2"}
  """
  def transform(attrs) do
    attrs
    |> to_dict(%{})
  end

  defp to_dict([], res), do: res
  defp to_dict([{key, _, [val]}|t], res) when is_list(key) and is_list(val) do
    key_as_atom = key
                  |> List.to_string()
                  |> String.to_atom()
    val_as_string = val
                    |> List.to_string()
    to_dict(
      t,
      Map.put_new(res, key_as_atom, val_as_string)
    )
  end
  defp to_dict([{key, _, val}|t], res) when is_list(key) and is_list(val) do
    key_as_atom = key
                  |> List.to_string()
                  |> String.to_atom()
    to_dict(
      t,
      Map.put_new(res, key_as_atom, "")
    )
  end
  defp to_dict(_, _), do: raise "Unhandled input types."
end
