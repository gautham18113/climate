defmodule Climate.Fetch do

  @moduledoc """
  This module interacts with https://w1.weather.gov/xml/current_obs and fetches
  an xml response.
  """

  @user_agent [{"User-agent", "Elixir gautham18113@gmail.com"}]
  @site_url "https://w1.weather.gov/xml/current_obs"

  @doc """
  This method that performs necessary steps to fetch data from the website.
  Returns `{:ok, body, 200}` for a successful response, else it returns
  `{:error, err, status_code}` for a failed response.
  """
  def fetch(location) do
    location
    |> generate_url()
    |> HTTPoison.get(@user_agent)
    |> handle_response()
  end

  defp generate_url(loc) do
    "#{@site_url}/#{loc}.xml"
  end

  defp handle_response({:ok, %{body: body, status_code: 200}}) do
    body
  end

  defp handle_response({_, %{body: _, status_code: status_code}}) do
    raise "Invalid response, status_code: #{status_code}"
  end

end
