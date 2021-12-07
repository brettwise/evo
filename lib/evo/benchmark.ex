defmodule Evo.Benchmark do
  def measure_execution_time(func) when func |> is_function do
    {µs, _} = :timer.tc(fn -> func.() end)

    IO.puts("""

    	µs: #{Aja.Integer.decimal_format(µs) <> "µs"}
    	ms: #{handle_ms_conversion(µs)}
    	 s: #{handle_sec_conversion(µs)}
    """)
  end

  def measure_execution_time(_),
    do: raise("Must pass function in, you probably passed a value by accident")

  defp handle_ms_conversion(µs) do
    cond do
      µs < 1_000 -> "< 1"
      true -> round(µs / 1_000) |> Aja.Integer.decimal_format()
    end <> "ms"
  end

  defp handle_sec_conversion(µs) do
    if µs < 100_000 do
      "≈ 0"
    else
      Float.round(µs / 1_000_000, 2) |> Float.to_string()
    end <> "s"
  end
end
