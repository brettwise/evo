defmodule Evo.World.Entities do
  @attributes ~w(
    age
    bears_offspring
    color
    energy
    energy_content
    fertility
    growth_rate
    id
    lifespan
    sexual_maturity_range
    size
    max_size
  )a

  @enforce_keys @attributes
  defstruct @attributes

  import Evo.Generators

  def new_entity(attrs) do
    %__MODULE__{
      age: 0,
      bears_offspring: attrs[:bears_offspring] || random_bool(),
      color: attrs[:color] || random_rgb(),
      energy: attrs[:energy] || random(20..60),
      energy_content: attrs[:energy_content] || random(20..60),
      fertility: attrs[:fertility] || random(30..80),
      growth_rate: attrs[:growth_rate] || random(40..80),
      id: Ecto.UUID.generate(),
      lifespan: attrs[:lifespan] || random(20..80),
      sexual_maturity_range: attrs[:sexual_maturity_range] || random(15..45),
      size: attrs[:size] || random(1..9),
      max_size: attrs[:max_size] || random(15..20)
    }
  end

  defp random_rgb do
    {random(255), random(255), random(255)}
  end
end
