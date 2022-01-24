defmodule Evo.Engines.TimeKeeper do
  @moduledoc """
  Responsible for advancing time/turns/steps & recording history.
  """

  @doc """
  Takes state, returns it w/ updated history
  """
  def record_history(state) do
    state
    |> Map.get_and_update!(:history, &{&1, put_current_state(&1, state)})
    |> elem(1)
  end

  @doc """
  Increments the time unit `tick`.
  """
  def increment_time(state) do
    state
    |> Map.get_and_update!(:tick, &{&1, &1 + 1})
    |> elem(1)
  end

  defp put_current_state(history, state) do
    Map.put(history, state.tick, state.current_state)
  end
end
