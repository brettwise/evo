defmodule EvoTest.WorldTest.MatrixTest do
  use ExUnit.Case, async: true

  alias Evo.World.Matrix
  alias Aja.Vector
  alias Evo.World.Entities.Blarg
  alias Evo.World.Entities.Vlem

  import Aja, only: [vec: 1, vec_size: 1]

  describe "create_matrix_from_vector/3" do
    test "returns vector of x vectors containing x elements" do
      size = 3
      vector_length = size * size

      vector_of_nils = Vector.duplicate(nil, vector_length)

      actual = Matrix.create_matrix_from_vector(vector_of_nils, size)

      expected =
        vec([
          vec([nil, nil, nil]),
          vec([nil, nil, nil]),
          vec([nil, nil, nil])
        ])

      assert actual == expected
    end
  end

  describe "randomly_place_entities/3" do
    test "returns entities randomly placed in matrix along w/ index where they were placed" do
      empty_matrix = Matrix.create_matrix_from_vector(Vector.duplicate(nil, 9), 3)

      entity_vector = vec([Blarg.new(), Blarg.new(), Vlem.new()])

      {actual_matrix, actual_index} = Matrix.randomly_place_entities(empty_matrix, entity_vector)

      # assert index coords return something (not nil)
      Enum.map(actual_index, fn {x, y} = _single_coord -> assert actual_matrix[x][y] !== nil end)
    end
  end

  describe "new_new/2" do
    test "returns a matrix struct" do
      entity_vector = vec([Blarg.new(), Blarg.new(), Vlem.new()])
      actual_matrix = Matrix.new_new(3, entity_vector)

      assert %Matrix{} = actual_matrix
    end

    test "returns a matrix, aka vector of vectors, where size specifies height, number of vectors inside of outside vector, and width, number of elements in each inner vector, which are equal" do
      expected_matrix_height_and_width = 3

      entity_vector = vec([Blarg.new(), Blarg.new(), Vlem.new()])
      %Matrix{matrix: actual_matrix} = Matrix.new_new(expected_matrix_height_and_width, entity_vector)

      actual_matrix_height = vec_size(actual_matrix)
      actual_matrix_width = vec_size(actual_matrix[0])

      assert actual_matrix_height == expected_matrix_height_and_width
      assert actual_matrix_width == expected_matrix_height_and_width
    end
  end
end
