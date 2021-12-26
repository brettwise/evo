defmodule Evo.World.Matrix do
  @moduledoc """
  A `Matrix` models the physical space Entities move through. This is most of the state that constitutes a
  `World`.
  """

  @attributes [:matrix, :entity_index, :graveyard]
  @enforce_keys @attributes
  defstruct @attributes
  alias Aja.Vector
  alias Evo.World.Matrix
  alias Evo.World.Matrix.Square
  import Aja, only: [+++: 2, vec: 1, vec_size: 1]
  import Evo.Generators

  @doc """
  Takes a map size and some entities to place in that map and returns a matrix with those entities randomly
  placed.
  """
  def new(size, entities) do
    # nil represents empty coordinates
    vector_of_empty_coords = Aja.Vector.duplicate(nil, _total_coord_points = size * size)

    vector_of_empty_coords
    |> create_matrix_from_vector(size)
    |> then(fn empty_matrix ->
      entity_index = generate_random_coords(_number_of_coords_to_gen = vec_size(empty_matrix))

      populated_matrix = place_entities(empty_matrix, entities, entity_index)

      %Matrix{
        matrix: populated_matrix,
        entity_index: entity_index,
        graveyard: nil
      }
    end)
  end

  @doc """
  Creates a matrix from a vector, aka a 2 dimensional vector or vector of vectors.

  Example:
  vec([
    vec([nil, nil, nil]),
    vec([nil, %{soil...}, nil]),
    vec([nil, nil, nil])
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

  defp generate_random_coords(number_of_coords_to_gen),
    do: generate_random_coords(number_of_coords_to_gen, number_of_coords_to_gen - 1, [])

  defp generate_random_coords(coords_left_to_gen, max_num_to_gen, coord_acc) do
    if coords_left_to_gen == 0 do
      coord_acc
    else
      random_coord = {Enum.random(0..max_num_to_gen), Enum.random(0..max_num_to_gen)}

      if _coord_generated_already? = Enum.member?(coord_acc, random_coord) do
        generate_random_coords(coords_left_to_gen, max_num_to_gen, coord_acc)
      else
        generate_random_coords(
          coords_left_to_gen - 1,
          max_num_to_gen,
          [random_coord] ++ coord_acc
        )
      end
    end
  end

  defp place_entities(matrix, entities, random_coords) do
    if entities == vec([]) do
      matrix
    else
      [{x, y} | remaining_random_coords] = random_coords
      {entity, remaining_entities} = Vector.pop_last!(entities)

      updated_matrix =
        Vector.get_and_update(matrix, x, fn vec_row ->
          {vec_row, Vector.replace_at!(vec_row, y, Square.new(entity))}
        end)
        |> elem(1)

      place_entities(updated_matrix, remaining_entities, remaining_random_coords)
    end
  end
end

defmodule Evo.World.Matrix.Square do
  @moduledoc """
  A `Square` represents a single coordinate point in a `Matrix`. It contains the entities that make up the
  current state of the world.
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
