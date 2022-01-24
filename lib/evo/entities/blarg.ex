defmodule Evo.Entities.Blarg do
  @moduledoc """
  The Blarg is a mammalian entity. They eat Vlems, bear children, and have other attributes one expects of mammals.

  ----- scratchpad ------
  Blarg.look(blarg, {x, y}) :: [{x, y}]
  Blarg.evaluate(blarg, tuple_list)
    function of determining greatest need (energy 1st, mating second)
    if hungry
      check for vlem on current square
        if found
          plan eat
        else
          search squares for vlem
          if found make plan to move
    all blargs have made plan
    judge checks for conflicting plans resolves conflicts by checking stats for planned action, best wins
    then execute plans which updates the map
  """
  @attributes ~W(common_attrs hunger speed visual_acuity)a
  @enforce_keys @attributes
  defstruct @attributes

  alias Evo.Entities
  import Evo.Randomizer

  def new(attrs \\ []) do
    %__MODULE__{
      common_attrs: Entities.new_entity([]),
      hunger: attrs[:hunger] || 10,
      speed: random(40..80),
      visual_acuity: acuity_gen()
    }
  end

  def create_population(count) do
    1..count
    |> Enum.into([], fn _int ->
      new()
    end)
  end

  defp acuity_gen do
    case random(1..10_000) do
      1 ->
        # Log.append("A blind blarg was born.")
        0

      num when num > 9_995 ->
        # Log.append("A blarg with super vision was born.")
        random(95..100)

      _num ->
        random(40..80)
    end
  end
end
