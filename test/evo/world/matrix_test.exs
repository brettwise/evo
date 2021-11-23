defmodule EvoTest.WorldTest.MatrixTest do
  use ExUnit.Case, async: true

  alias Evo.World.Matrix
  alias Aja.Vector

  import Aja, only: [vec_size: 1]

  describe "record_world_history/1" do
    test "given specified size returns square vector with those dimensions" do
      vector_size = 3
      actual_matrix = Matrix.populate_new_map(vector_size, Vector.new([:entity]))

      actual_size = vec_size(actual_matrix)
      expected_size = vector_size
      assert actual_size == expected_size
    end
  end
end
