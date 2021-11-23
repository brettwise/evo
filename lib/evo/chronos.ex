defmodule Evo.Chronos do
  @moduledoc """
  Named after the greek god of time. Responsible for time & history.
  """

  @doc """
  Takes a world, returns it w/ updated history
  """
  def record_world_history(world) do
    world
    |> Map.get_and_update!(:history, &{&1, put_current_state(&1, world)})
    |> elem(1)
  end

  @doc """
  Simply increments the time unit `tick`.
  """
  def increment_time(world) do
    world
    |> Map.get_and_update!(:tick, &{&1, &1 + 1})
    |> elem(1)
  end

  defp put_current_state(history, world) do
    Map.put(history, world.tick, world.current_state)
  end
end
