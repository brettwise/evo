defmodule Evo.World.Entities.Vlem do
  alias Evo.World.Entities
  import Evo.Generators

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
