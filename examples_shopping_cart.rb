# frozen_string_literal: true

require_relative 'shopping_cart'

cart = ShoppingCart.new

cart.set('Product1', 1)

puts("size: #{cart.size}")
puts(cart.to_string)
puts

find = cart.find_name('product1')
if find.nil?
	cart.set('product1', 0)
else
	cart.set(find[:name], find[:price], find[:count] + 1)
end

puts("size: #{cart.size}")
puts(cart.to_string)
puts

cart.set('product3', 3, 1)
cart.set('product2', 2, 2)
cart.set('product1', 1.1)

puts("sum: #{cart.sum}")
puts("size: #{cart.size}")
puts(cart.to_string)
puts

cart.sort
puts(cart.to_string)
