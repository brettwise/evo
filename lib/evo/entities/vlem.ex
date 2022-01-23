defmodule Evo.Entities.Vlem do
  @moduledoc """
  Vlems are the plant based life form that reproduce through pollination and grow in the ground and generally have the
  attributes one would expect plants to have.
  """
  alias Evo.Entities
  import Evo.Randomizer

  defstruct ~W(
    common_attrs
    pollination_rate
    seed_release_rate
  )a

  def new(attrs \\ []) do
    %__MODULE__{
      common_attrs: Entities.new_entity([]),
      pollination_rate: attrs[:pollination_rate] || 10,
      seed_release_rate: random(40..80)
    }
  end

  def create_population(count) do
    1..count
    |> Enum.into(%{}, fn _int ->
      vlem = new()
      {vlem.common_attrs.id, vlem}
    end)
  end
end
