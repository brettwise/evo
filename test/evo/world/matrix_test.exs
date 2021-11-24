defmodule EvoTest.WorldTest.MatrixTest do
  use ExUnit.Case, async: true

  alias Evo.World.Matrix
  alias Aja.Vector

  import Aja, only: [vec_size: 1]

  describe "populate_new_map/1" do
    test "given specified size returns square vector with those dimensions" do
      vector_size = 3
      actual_matrix = Matrix.populate_new_map(vector_size, Vector.new([:entity]))

      # vector should be vector_size rows tall
      actual_size = vec_size(actual_matrix)
      expected_size = vector_size
      assert actual_size == expected_size

      # each row should have vector_size members
      actual_matrix
      |> Vector.map(fn matrix_row ->
        assert matrix_row |> vec_size == vector_size
      end)
    end
  end
end
