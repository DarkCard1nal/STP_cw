# frozen_string_literal: true

# Class ShoppingCart stores the shopping cart and performs operations with it,
# stores an array of hashes in the form {name: product_name, price: product_price, count: count}
class ShoppingCart
	def initialize
		@cart = []
	end

	# The method returns a copy of the basket array
	def cart
		Marshal.load(Marshal.dump(@cart))
	end

	# The method returns the number of product types in the cart
	def size
		@cart.size
	end

	# The method returns a copy of the found hash by :name case insensitive, or nil
	def find_name(product_name)
		return nil unless product_name.is_a?(String)

		find_name_ref(product_name).dup
	end

	# The method adds a new product or changes an existing one,
	# returns nil on successful execution, or an error text
	def set(product_name, product_price, count = 1) # rubocop:disable Metrics/MethodLength
		product_price = ShoppingCart.to_numeric(product_price)
		count = ShoppingCart.to_numeric(count)
		return "#{product_name} is incorrect name (is not String)" unless ShoppingCart.name_correct?(product_name)
		return "#{product_price} #{count}" unless product_price.is_a?(Numeric) && count.is_a?(Numeric)

		product = find_name_ref(product_name)
		if product.nil?
			@cart.push({ name: product_name, price: product_price, count: count })
		else
			product[:name] = product_name
			product[:price] = product_price
			product[:count] = count
		end

		nil
	end

	# The method sorts the cart list by name case insensitive
	def sort
		@cart.sort_by! { |product| product[:name].downcase }
		nil
	end

	# The method sorts the cart list by name case insensitive
	def sum
		return 0 if @cart.empty?

		@cart.sum { |product| product[:price] * product[:count] }
	end

	# The method returns a string with cart items and total price for easy display
	def to_string
		result = "ShoppingCart: \n"
		result += " № | name | price | count\n"
		@cart.each_with_index do |product, index|
			result += "#{index + 1} | #{product[:name]} | #{product[:price]} | #{product[:count]}\n"
		end
		result += "sum: #{sum}\n"

		result
	end

	# The static method checks if the input is Numeric, if not, tries to convert it to Float,
	# returns Numeric or error text if conversion failed
	def self.to_numeric(input)
		return input if input.is_a?(Numeric)

		num = Float(input, exception: false)
		num = "Error! #{input} is not a number and could not be converted to a number!" if num.nil?

		num
	end

	# The static method checks if name is a String, returns true if it is a String, or false.
	def self.name_correct?(name)
		return true if name.is_a?(String)

		false
	end

	# The private method returns a reference to the found hash, case sensitive :name or nil
	def find_name_ref(product_name)
		@cart.find { |product| product[:name].casecmp(product_name).zero? }
	end

	private :find_name_ref
end
