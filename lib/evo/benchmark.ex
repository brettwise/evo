defmodule Evo.Benchmark do
	def measure_execution_time(func) when func |> is_function do
		{µs, _} = :timer.tc(fn -> func.() end)

		[
			µs: Aja.Integer.decimal_format(µs),
			ms: round(µs / 1000) |> Aja.Integer.decimal_format(),
			s: Float.round(µs / 1_000_000, 2) |> Float.to_string
		]
	end

	def measure_execution_time(_), do:
		raise "Must pass function in, you probably passed a value by accident"
end