# STP_cw

_Created for the course "Stack of programming technologies" V. N. Karazin Kharkiv National University_

Ruby 3.3.5 module ArrayAverageValue and class ShoppingCart.

---

Module `ArrayAverageValue` is located in the file `array_average_value.rb`.

Class `ShoppingCart` is located in the file `shopping_cart.rb`.

Minitest tests are in the directory `.minitest`.

# Module ArrayAverageValue

Module ArrayAverageValue calculates the average value of the array elements

### Methods:

- `self.average(array)` - The method returns the average value without checking the `array` for non-numeric elements, if such elements are present, an error may occur, if the `array` is `empty` returns `0`.
- `self.average_safe_all(array)` - The method returns the average value, checking the `array` for non-numeric elements, returns the average value from all elements of the `array`, if the `array` is `empty` returns `0`.
- `self.average_safe_only_numbers(array)` - The method returns the average value, checking the `array` for non-numeric elements, returns the average value only from the `Numeric` elements of the `array`, if the `array` is `empty` returns `0`.

### Usage (examples_array_average_value.rb):

```ruby
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
```

**Outputs:**

```shell
> ruby examples_array_average_value.rb
average
[0, 1.1, 2.2, 3.3, 4.4, 5.5, 6.6, 7.7, 8.8, 9.9]
average: 4.95

average_safe_all
[0, 1.1, nil, 3, 4, "abs", 6, 7, 8, 9]
average: 3.81

average_safe_only_numbers
[0, 1.1, nil, 3, 4, "abs", 6, 7, 8, 9]
average: 4.7625
```

# Class ShoppingCart

Class ShoppingCart stores the shopping cart and performs operations with it.
Stores an array of hashes in the form

```ruby
{name: product_name, price: product_price, count: count}
```

### Methods:

- `cart` - The method returns a copy of the basket array.
- `size` - The method returns the number of product types in the cart.
- `find_name(product_name)` - The method returns a copy of the found hash by `:name` case insensitive, or `nil`.
- `set(product_name, product_price, count = 1)` - The method adds a new product or changes an existing one, returns `nil` on successful execution, or an error text.
- `sort` - The method sorts the cart list by `:name` case insensitive.
- `sum` - The method returns the total price of all items in the cart.
- `to_string` - The method returns a `string` with cart items and total price for easy display.
- `self.to_numeric(input)` - The static method checks if the input is `Numeric`, if not, tries to convert it to `Float`, returns `Numeric` or error text if conversion failed.
- `self.name_correct?(name)` - The static method checks if `name` is a `String`, returns `true` if it is a `String`, or `false`.

### Usage (examples_shopping_cart.rb):

```ruby
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
```

**Outputs:**

```shell
> ruby examples_shopping_cart.rb
size: 1
ShoppingCart:
 № | name | price | count
1 | Product1 | 1 | 1
sum: 1

size: 1
ShoppingCart:
 № | name | price | count
1 | Product1 | 1 | 2
sum: 2

sum: 8.1
size: 3
ShoppingCart:
 № | name | price | count
1 | product1 | 1.1 | 1
2 | product3 | 3 | 1
3 | product2 | 2 | 2
sum: 8.1

ShoppingCart:
 № | name | price | count
1 | product1 | 1.1 | 1
2 | product2 | 2 | 2
3 | product3 | 3 | 1
sum: 8.1
```
