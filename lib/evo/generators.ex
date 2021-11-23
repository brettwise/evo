defmodule Evo.Generators do
  @moduledoc """
  Provides functions to generate random values.
  """
  def random(int) when int |> is_integer, do: 0..int |> rand()
  def random(range) when range |> is_struct, do: range |> rand()
  def random_bool, do: [true, false] |> rand()

  defp rand(enum), do: Enum.random(enum)
end
