defmodule EvoTest.RandomizerTest do
  use ExUnit.Case, async: true

  alias Evo.Randomizer

  describe "random/1" do
		@tag :focus
		test "given int returned int is between that number and 0" do
			actual = Randomizer.random(100)

			assert actual in 0..100
			assert actual |> is_integer
		end
  end
end
