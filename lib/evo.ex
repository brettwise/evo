defmodule Evo do
  @moduledoc """
  Entry point into the simulation aka all things Evo.
  """

  alias Evo.State
  alias Evo.Engines.Reaper
  alias Evo.Engines.TimeKeeper

  @doc """
  Runs the simulation by passing State through the Engines.
  """
  def run(%State{} = world, _opts) do
    # TODO: how will we handle pausing the simulation at a given step
    world
    |> Reaper.reap()
    |> TimeKeeper.record_history()
    |> TimeKeeper.increment_time()
  end

  def run(_opts) do
    State.new()
    |> run()
  end
end
