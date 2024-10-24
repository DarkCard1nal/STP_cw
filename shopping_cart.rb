# frozen_string_literal: true

# Class ShoppingCart
class ShoppingCart
	def initialize
		@cart = []
	end

	def cart
		Marshal.load(Marshal.dump(@cart))
	end

	def size
		@cart.size
	end

	def find_name(product_name)
		return nil unless product_name.is_a?(String)

		find_name_ref(product_name).dup
	end

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

	def sort
		@cart.sort_by! { |product| product[:name].downcase }
		nil
	end

	def sum
		return 0 if @cart.empty?

		@cart.sum { |product| product[:price] * product[:count] }
	end

	def to_string
		result = "ShoppingCart: \n"
		result += " № | name | price | count\n"
		@cart.each_with_index do |product, index|
			result += "#{index + 1} | #{product[:name]} | #{product[:price]} | #{product[:count]}\n"
		end
		result += "sum: #{sum}\n"

		result
	end

	def self.to_numeric(input)
		return input if input.is_a?(Numeric)

		num = Float(input, exception: false)
		num = "Error! #{input} is not a number and could not be converted to a number!" if num.nil?

		num
	end

	def self.name_correct?(name)
		return true if name.is_a?(String)

		false
	end

	def find_name_ref(product_name)
		@cart.find { |product| product[:name].casecmp(product_name).zero? }
	end

	private :find_name_ref
end
