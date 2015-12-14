require 'benchmark'

ITERATIONS = 5000000

def run(hash, bench)
  bench.report("#{hash.keys.length} keys") do
    ITERATIONS.times do
      Hash[hash.to_a]
    end
  end
end

Benchmark.bm do |bench|
  run({a: 1, b: 2, c: 3}, bench)
  run({"a": 1, "b": 2, "c": 3}, bench)
  run({a: 1, b: 2, c: 3, d: 4}, bench)
  run({a: 1, b: 2, c: 3, d: 4, e: 5}, bench)
  run({a: 1, b: 2, c: 3, d: 4, e: 5, f: 6},bench)
  run({a: 1, b: 2, c: 3, d: 4, e: 5, f: 6, g: 7},bench)
  run({a: 1, b: 2, c: 3, d: 4, e: 5, f: 6, g: 7, h: 8},bench)
  run({a: 1, b: 2, c: 3, d: 4, e: 5, f: 6, g: 7, h: 8, i: 9},bench)
end
