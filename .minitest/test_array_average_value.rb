# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../array_average_value'

# Testing module ArrayAverageValue
class TestTask < Minitest::Test
	def test_average
		assert_equal(0, ArrayAverageValue.average([]), 'empty array')
		assert_equal(0, ArrayAverageValue.average([0]), '0 array')
		assert_equal(4.5, ArrayAverageValue.average([0, 1, 2, 3, 4, 5, 6, 7, 8, 9]), 'int array')
		assert_equal(4.95, ArrayAverageValue.average([0, 1.1, 2.2, 3.3, 4.4, 5.5, 6.6, 7.7, 8.8, 9.9]), 'float array')
		assert_equal(4.51, ArrayAverageValue.average([0, 1.1, 2, 3, 4, 5, 6, 7, 8, 9]), 'numbers array')
	end

	def test_average_safe_all
		assert_equal(0, ArrayAverageValue.average_safe_all([nil, nil]), 'nil array')
		assert_equal(3.81, ArrayAverageValue.average_safe_all([0, 1.1, nil, 3, 4, 'abs', 6, 7, 8, 9]), 'mix array')
	end

	def test_average_safe_only_numbers
		assert_equal(0, ArrayAverageValue.average_safe_only_numbers([nil, nil]), 'nil array')
		assert_equal(4.7625, ArrayAverageValue.average_safe_only_numbers([0, 1.1, nil, 3, 4, 'abs', 6, 7, 8, 9]), 'mix array')
	end
end
