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

  describe "new/2" do
    test "returns a matrix struct" do
      actual_matrix =
        Matrix.new(3, _entity_vector = vec([Blarg.new(), Blarg.new(), Vlem.new()]))

      assert %Matrix{} = actual_matrix
    end

    test "returns a matrix, aka vector of vectors, where size specifies an equal height (vectors inside of outside vector) and width (elements in each inner vector)" do
      %{matrix: actual_matrix} =
        Matrix.new(
          expected_matrix_height_and_width = 3,
          _entity_vector = vec([Blarg.new(), Blarg.new(), Vlem.new()])
        )

      actual_matrix_height = vec_size(actual_matrix)
      actual_matrix_width = vec_size(actual_matrix[0])

      assert actual_matrix_height == expected_matrix_height_and_width
      assert actual_matrix_width == expected_matrix_height_and_width
    end

    test "returns an entity index that corresponds to where entities were placed" do
      %{matrix: actual_matrix, entity_index: actual_entity_index} =
        Matrix.new(3, _entity_vector = vec([Blarg.new(), Blarg.new(), Vlem.new()]))

      # assert index coords return something (not nil)
      Enum.map(actual_entity_index, fn {x, y} = _single_coord ->
        assert actual_matrix[x][y] !== nil
      end)
    end
  end
end
