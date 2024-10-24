# frozen_string_literal: true

# Module ArrayAverageValue calculates the average value of the array elements
module ArrayAverageValue
	# The method returns the average value without checking the array for non-numeric elements,
	# if such elements are present, an error may occur,
	# if the array is empty returns 0
	def self.average(array)
		average_universal(array)
	end

	# The method returns the average value, checking the array for non-numeric elements,
	# returns the average value from all elements of the array,
	# if the array is empty returns 0
	def self.average_safe_all(array)
		average_universal(array.grep(Numeric), array.size)
	end

	# The method returns the average value, checking the array for non-numeric elements,
	# returns the average value only from the numeric elements of the array,
	# if the array is empty returns 0
	def self.average_safe_only_numbers(array)
		numbers = array.grep(Numeric)
		average_universal(numbers, numbers.size)
	end

	# Universal private method for the average value of array elements,
	# searches for the sum of array elements and divides by the number of array_size,
	# if the array is empty returns 0, does not check array elements
	def self.average_universal(array, array_size = array.size)
		return 0 if array.empty?

		array.sum.to_f / array_size
	end

	private_class_method :average_universal
end
