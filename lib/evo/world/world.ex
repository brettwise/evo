defmodule Evo.World do
  @moduledoc """
  A `World` contains the all the state that makes up an Evo simulation.
  """
  alias Aja.Vector
  alias Evo.Chronos
  alias Evo.World
  alias Evo.World.Matrix
  alias Evo.World.Reaper
  alias Evo.World.Entities.Blarg
  # alias Evo.World.Entities.Vlem

  @attributes ~W(history current_state tick)a
  @enforce_keys @attributes
  defstruct @attributes

  def run(%World{} = world, _opts) do
    world
    # |> Entities.do_things()
    |> Reaper.reap()
    |> Chronos.record_world_history()
    |> Chronos.increment_time()
  end

  def run(_opts) do
    new()
    |> run()
  end

  def new(size \\ 3) do
    population = Vector.new(Blarg.create_population(1))

    %World{
      current_state: Matrix.new_new(size, population),
      history: %{},
      tick: 0
    }
  end
end
