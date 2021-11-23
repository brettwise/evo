defmodule Evo.World.Reaper do
  @moduledoc """
  Responsible for making sure entities die when they are supposed to.
  """

  @doc """
  Takes the current worl
  """
  def reap(world) do
    # maps over world.map.occupied
    # any entities with 0 energy are removed from map, placed in hades, (square is fertilized)
    world
  end
end
