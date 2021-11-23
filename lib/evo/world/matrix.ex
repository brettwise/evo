defmodule Evo.World.Matrix do
  @moduledoc """
  A `Matrix` models the physical space Entities move through. This is most of the state that constitutes a `World`.

  ==== Notes ====
  What actions am I going to take on the matrix?

  Definitely going to randomly write to it as stuff moves around as well as dies on the map and fertilizes squares.

  Deletes are the only thing that is expensive with Aja vectors. But we don't need to do that.

  So if we had the full matrix and no record of where stuff was at in it we'd have to walk the full matrix each time to find
  the entities and then update them. Which is wasteful? We could just keep a separate vector of the occupied squares during each turn.
  Then we just iterate the occupied vector and go straight to that point in the matrix. but does that mean we are doing
  a deleted and insert on the occupied vector?
  """

  defstruct [:occupied, :unoccupied, :graveyard]
  alias Aja.Vector
  alias Evo.World.Matrix.Square
  import Aja, only: [+++: 2, vec: 1, vec_size: 1]
  import Evo.Generators

  def populate_new_map(size, entities) when vec_size(entities) > 0 do
    # calculate number of empty squares to put in vector
    empty_square_count = size * size - Vector.size(entities)

    empty_squares =
      1..empty_square_count
      |> Aja.Enum.into(vec([]), fn _int ->
        Square.new()
      end)

    populated_squares =
      entities
      |> Vector.new()
      |> Vector.map(&Square.new(&1))

    randomly_dispersed_entities =
      (populated_squares +++ empty_squares)
      |> Vector.shuffle()

    randomly_dispersed_entities
    |> create_matrix(size)
  end

  # a matrix aka a 2 dimensional vector aka a list of lists
  # [
  #   [:x, :x, :x, :x, :x],
  #   [:x, :x, :x, :x, :x],
  #   [:x, :x, :x, :x, :x],
  #   [:x, :x, :x, :x, :x],
  #   [:x, :x, :x, :x, :x]
  # ]
  def create_matrix(vector, size, acc \\ vec([]))

  def create_matrix({final_split, remaining}, _size, acc) when vec_size(remaining) == 0,
    do: vec([final_split]) +++ acc

  def create_matrix({split, remaining}, size, acc) do
    remaining
    |> Vector.split(size)
    |> create_matrix(size, vec([split]) +++ acc)
  end

  def create_matrix(vector, size, acc) do
    vector
    |> Vector.split(size)
    |> create_matrix(size, acc)
  end
end

defmodule Evo.World.Matrix.Square do
  @moduledoc """
  A `Square` represents a single coordinate point in a `Matrix`. It contains the entities that make up the current
  state of the world.
  """
  import Evo.Generators

  @doc """
  Contains ground fertility, any entity if spawned, and space for a reproductive mate if mating.
  """
  def new(entity \\ nil) do
    {random(5..10), entity, nil}
  end
end
