# frozen_string_literal: true

require_relative 'array_average_value'

arr1 = [0, 1.1, 2.2, 3.3, 4.4, 5.5, 6.6, 7.7, 8.8, 9.9]
arr2 = [0, 1.1, nil, 3, 4, 'abs', 6, 7, 8, 9]

puts('average')
p arr1
average = ArrayAverageValue.average(arr1)
puts("average: #{average}")

puts
puts('average_safe_all')
p arr2
average = ArrayAverageValue.average_safe_all(arr2)
puts("average: #{average}")

puts
puts('average_safe_only_numbers')
p arr2
average = ArrayAverageValue.average_safe_only_numbers(arr2)
puts("average: #{average}")
