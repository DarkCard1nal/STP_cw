# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../shopping_cart'

# Testing class ShoppingCart
class TestShoppingCart < Minitest::Test
	def setup
		@cart = ShoppingCart.new
	end

	def test_initialize
		assert_equal(0, @cart.size, 'cart is not empty')
		assert_equal([], @cart.cart, 'cart is not array')
	end

	def test_set # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
		product1 = { name: 'Product1', price: 1, count: 1 }
		product2 = { name: 'Product2', price: 2, count: 2.2 }
		assert_nil(@cart.set('Product1', 1), 'cart not add Product1')
		assert_nil(@cart.set('product2', 2.2, 2.3), 'cart not add product2')
		assert_nil(@cart.set('Product2', 2, 2.2), 'cart not update Product2')
		refute_nil(@cart.set('Product3', 3, 'a'), 'cart add incorrect Product3 count')
		refute_nil(@cart.set('Product4', 3, nil), 'cart add incorrect Product4 count')
		refute_nil(@cart.set('Product5', 'a', 3), 'cart add incorrect Product5 price')
		refute_nil(@cart.set('Product6', nil, 3), 'cart add incorrect Product6 price')
		refute_nil(@cart.set(2, 3), 'cart add incorrect product name')
		refute_nil(@cart.set(nil, 3), 'cart add incorrect product name')
		assert_equal(2, @cart.size, 'cart size is not 2')
		assert_equal([product1, product2], @cart.cart, 'cart array incorrectly assembled')
	end

	def test_find_name
		@cart.set('Product1', 1)
		@cart.set('Product2', 2)
		@cart.set('Product3', 3)
		assert_nil(@cart.find_name('Product4'), 'cart found a nonexistent Product4')
		assert_nil(@cart.find_name(nil), 'cart found a nonexistent nil')
		assert_kind_of(Hash, @cart.find_name('Product1'), 'cart not found Product1')
		assert_kind_of(Hash, @cart.find_name('product2'), 'cart not found Product2')
		hash1 = @cart.find_name('Product1')
		hash1[:price] = 4
		refute_equal(hash1, @cart.find_name('Product1'), 'broken encapsulation when issuing search results Product1')
	end

	def test_sort
		product1 = { name: 'Product1', price: 1, count: 1 }
		product2 = { name: 'product2', price: 2, count: 1 }
		product3 = { name: 'Product3', price: 3, count: 1 }
		@cart.set('Product3', 3)
		@cart.set('product2', 2)
		@cart.set('Product1', 1)
		@cart.sort
		assert_equal([product1, product2, product3], @cart.cart, 'cart incorrectly sort array')
	end

	def test_sum
		assert_equal(0, @cart.sum, 'cart incorrectly sum of array 0')
		@cart.set('Product3', 3)
		@cart.set('Product2', 2.4, 2)
		@cart.set('Product1', 1)
		assert_equal(8.8, @cart.sum, 'cart incorrectly sum of array')
	end

	# rubocop:disable Layout/LineEndStringConcatenationIndentation, Layout/ArgumentAlignment, Metrics/MethodLength
	def test_to_string
		assert_equal("ShoppingCart: \n " \
						"№ | name | price | count\nsum: 0\n",
						@cart.to_string, 'cart incorrectly to_string of array 0')
		@cart.set('Product3', 3)
		@cart.set('Product2', 2.4, 2)
		@cart.set('Product1', 1)
		assert_equal("ShoppingCart: \n " \
						"№ | name | price | count\n" \
						"1 | Product3 | 3 | 1\n" \
						"2 | Product2 | 2.4 | 2\n" \
						"3 | Product1 | 1 | 1\n" \
						"sum: 8.8\n",
						@cart.to_string, 'cart incorrectly to_string of array 0')
	end
	# rubocop:enable Layout/LineEndStringConcatenationIndentation, Layout/ArgumentAlignment, Metrics/MethodLength
end
