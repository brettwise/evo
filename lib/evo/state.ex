defmodule Evo.State do
  @moduledoc """
  State contains all the state that makes up an Evo simulation.
  """
  alias Aja.Vector
  alias Evo.State
  alias Evo.State.Matrix
  alias Evo.Entities.Blarg
  # alias Evo.Entities.Vlem

  @attributes ~W(history current_state tick)a
  @enforce_keys @attributes
  defstruct @attributes

  def new(size \\ 3) do
    population = Vector.new(Blarg.create_population(1))

    %State{
      current_state: Matrix.new(size, population),
      history: %{},
      tick: 0
    }
  end
end
