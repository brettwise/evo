## Learnings

### A little about `make_vector_of_empty_squares`
initially I was newing up a default square for each vector member w/
```elixir
1..count
|> Aja.Enum.into(vec([]), fn _int ->
  Coordinate.new()
end)
```
This turns out to be kind of expensive. Returning `nil` is 7 times faster (per my timings in iex).

But then I realized just using `Vector.duplicate` was an order of magnitude faster than this even.

If you need a random soil fertility value, only thing in an empty square, it is faster to just generate it on the fly.

## Notes

### Evo.State.Matrix

What actions am I going to take on the matrix?

Definitely going to randomly write to it as stuff moves around as well as dies on the map and fertilizes squares.

Deletes are the only thing that is expensive with Aja vectors. But we don't need to do that.

So if we had the full matrix and no record of where stuff was at in it we'd have to walk the full matrix each time to find the entities and then update them. Which is wasteful? We could just keep a separate vector of the occupied squares during each turn.

Then we just iterate the occupied vector and go straight to that point in the matrix. but does that mean we are doing a deleted and insert on the occupied vector?


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