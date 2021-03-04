require 'benchmark'

Benchmark.bm(10) do |x|
  x.report("10,000回") do
    arr = []
    (0...10000).each { |i| arr.push(i) }
  end
  x.report("100回") do
    arr = []
    (0...100).each { |i| arr.push(i) }
  end
end

@drinks.drink[n-1][:stock] -= 1
@insert_money -= @drinks.drink[n-1][:price]
@sales_amount += @drinks.drink[n-1][:price]
