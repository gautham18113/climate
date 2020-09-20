defmodule Climate.Parse do

  @moduledoc """
  Parses an XML string using the `erlsom` module. Using
  `:erlsom.simple_form()` returns a tag in the form
  `{ok, SimpleFormElement, Rest}`. The `SimpleFormElement` contains
  `{Tag, Attributes, Content}`. For the purposes of this application, we
  are only interested in the `Content` of the wrapper body tag.
  """

  @doc """
  Parses the xml string provided in binary utf8 format and returns'
  just the content.
  """
  def parse_xml(xml) when is_binary(xml) do
    xml
    |> :erlsom.simple_form()
    |> handle_result()
  end
  def parse_xml(_), do: raise "Invalid XML binary"

  defp handle_result({:ok, {_, _, content}, _}), do: content

  defp handle_result(_), do: raise "Invalid parse result"
end
