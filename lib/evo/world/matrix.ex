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
  @attributes [:matrix, :entity_index, :graveyard]
  @enforce_keys @attributes
  defstruct @attributes
  alias Aja.Vector
  alias Evo.World.Matrix
  alias Evo.World.Matrix.Square
  import Aja, only: [+++: 2, vec: 1, vec_size: 1]
  import Evo.Generators

  def new(matrix, entity_index) do
    %Matrix{
      matrix: matrix,
      entity_index: entity_index,
      graveyard: nil
    }
  end

  @doc """
  Q: do I create the index as I build this up?
  Q: is there any advantage to that?
  A: no there aren't. but if I create and index by
  """
  def populate_new_map(size, entities) when vec_size(entities) > 0 do
    # calculate number of empty squares to put in vector
    empty_square_count = size * size - Vector.size(entities)

    # makes them
    empty_squares =
      1..empty_square_count
      |> Aja.Enum.into(vec([]), fn _int ->
        # initially I was newing up a default square for each vector member
        # this turns out to be kind of expensive
        # returning nil is 7 times faster (per my timings in iex)
        # if you need a random soil fertility value, only thing in an empty square
        # you just generate it on the fly
        # Square.new()
        nil
      end)

    # creates a vector of populated squares
    populated_squares =
      entities
      |> Vector.new()
      |> Vector.map(&Square.new(&1))

    # combines and shuffles squares so entities are randomly dispersed in matrix
    randomly_dispersed_entities =
      (populated_squares +++ empty_squares)
      |> Vector.shuffle()

    # takes that single vector and makes it into a matrix for an easier time
    # thinking about things moving around map
    randomly_dispersed_entities
    |> create_matrix_from_vector(size)
  end

  def new_new(size, entities) do
    size
    |> calculate_matrix_element_total()
    |> make_vector_of_empty_squares()
    |> create_matrix_from_vector(size)
    |> randomly_place_entities(entities)
    |> create_matrix_struct()
  end

  defp calculate_matrix_element_total(size), do: size * size

  # History
  # initially I was newing up a default square for each vector member w/
  # 1..count
  # |> Aja.Enum.into(vec([]), fn _int ->
  #   Square.new()
  # end)
  # this turns out to be kind of expensive
  # returning nil is 7 times faster (per my timings in iex)
  # But then I realized just using Vector.duplicate was an order of magnitude
  # faster than this even
  # if you need a random soil fertility value, only thing in an empty square,
  # it is faster to just generate it on the fly
  def make_vector_of_empty_squares(count) do
    Aja.Vector.duplicate(nil, count)
  end

  @doc """
  Creates a matrix from a vector, aka a 2 dimensional vector or vector of vectors.

  example:

  vec([
    vec([:x, :x, :x, :x, :x]),
    vec([:x, :x, :x, :x, :x]),
    vec([:x, :x, :x, :x, :x]),
    vec([:x, :x, :x, :x, :x]),
    vec([:x, :x, :x, :x, :x])
  ])
  """
  def create_matrix_from_vector(vector, size, acc \\ vec([])) do
    case vector do
      {final_split, vec([])} ->
        vec([final_split]) +++ acc

      {split, remaining} ->
        remaining
        |> Vector.split(size)
        |> create_matrix_from_vector(size, vec([split]) +++ acc)

      _first_call ->
        vector
        |> Vector.split(size)
        |> create_matrix_from_vector(size, acc)
    end
  end

  def randomly_place_entities(empty_matrix, entities) do
    size = vec_size(empty_matrix)
    entity_index = gen_random_coords(size - 1, size)

    populated_matrix = place_entities(empty_matrix, entities, entity_index)
    {populated_matrix, entity_index}
  end

  defp gen_random_coords(max_num_to_gen, coords_left_to_gen, random_coords \\ []) do
    if coords_left_to_gen == 0 do
      random_coords
    else
      random_coord = {Enum.random(0..max_num_to_gen), Enum.random(0..max_num_to_gen)}
      random_coord_generated_already? = Enum.member?(random_coords, random_coord)

      if random_coord_generated_already? do
        gen_random_coords(max_num_to_gen, coords_left_to_gen, random_coords)
      else
        gen_random_coords(max_num_to_gen, coords_left_to_gen - 1, [random_coord] ++ random_coords)
      end
    end
  end

  defp place_entities(populated_matrix, vec([]) = _entities, [] = _random_coords),
    do: populated_matrix

  defp place_entities(matrix, entities, [{x, y} | random_coords]) do
    {entity, remaining_entities} = Vector.pop_last!(entities)

    place_entities(
      place_entity_in_matrix_at!(matrix, entity, x, y),
      remaining_entities,
      random_coords
    )
  end

  defp place_entity_in_matrix_at!(matrix, entity, x, y) do
    matrix
    |> Vector.get_and_update(
      x,
      fn vec_row ->
        {vec_row, Vector.replace_at!(vec_row, y, Square.new(entity))}
      end
    )
    |> elem(1)
  end

  defp create_matrix_struct({matrix, entity_index}), do: new(matrix, entity_index)
end

defmodule Evo.World.Matrix.Square do
  @moduledoc """
  A `Square` represents a single coordinate point in a `Matrix`. It contains the entities that make up the current
  state of the world.
  """
  alias Evo.World.Entities.Blarg
  alias Evo.World.Entities.Vlem
  import Evo.Generators

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
