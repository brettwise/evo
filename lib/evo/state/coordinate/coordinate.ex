defmodule Evo.State.Matrix.Coordinate do
  @moduledoc """
  A Coordinate represents a single coordinate point in a Matrix. It contains the entities that make up the
  current state of the world.
  """
  alias Evo.Entities.Blarg
  alias Evo.Entities.Vlem
  import Evo.Randomizer

  @doc """
  Contains soil fertility rating, blarg or vlem and space for mate when the time comes.
  """
  def new(entity \\ nil)
  def new(%Blarg{} = blarg), do: square(nil, blarg)
  def new(%Vlem{} = vlem), do: square(vlem, nil)
  def new(_empty_square), do: square(nil, nil)

  defp square(vlem, blarg) do
    %{
      soil_fertility: random_soil_fertility(),
      vlem: vlem,
      blarg: blarg,
      blarg_mate: nil
    }
  end

  defp random_soil_fertility, do: random(30..70)
end
