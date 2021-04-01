Note that these variables may be reused accross the examples below

array = Array.new(100) { rand(0...9) }
range = Range.new(5, 50)
true_block = proc { |num| num <= 9 }
false_block = proc { |num| num > 9 }
words = %w[dog door rod blade]

#my_each
[1,2,3].my_each.class == Enumerator
[1,2,3].my_each_with_index.class == Enumerator
[1,2,3,4].my_select.class==Enumerator
[1,2,3,4].my_select.class==Enumerator

## my_all

array.my_all?(&true_block) == array.all?(&true_block)
array.my_all?(&false_block) == array.all?(&false_block)
range.my_all?(&false_block) == range.all?(&false_block)

true_array = [1, true, 'hi', []]
true_array.my_all? == true_array.all?

false_array = [1, false, 'hi', []]
false_array.my_all? == false_array.all?

array.my_all?(Integer) == array.all?(Integer)
numbers.my_all?(Numeric) == numbers.all?(Numeric)
words.my_all?(/d/) == words.all?(/d/)
words.my_all?(/o/) == words.all?(/o/)

array = [] # Note: This is NOT the same 'array' in the global scope
10.times { array << 3 }

# Expectation

array.my_all?(3) == array.all?(3)

# Using the 'array' variable in the global scope

# Expectation

array.my_all?(3) == array.all?(3)

## my_any

array.my_any?(&false_block) == array.any?(&false_block)
range.my_any?(&false_block) == range.any?(&false_block)
false_array.my_any? == false_array.any?
words.my_any?(Integer) == words.any?(Integer)
words.my_any?(/z/) == words.any?(/z/)
words.my_any?('cat') == words.any?('cat')

# my_none

array.my_none?(&true_block) == array.none?(&true_block)
range.my_none?(&false_block) == range.none?(&false_block)
true_array.my_none? == false
words.my_none?(/z/) == words.none?(/z/)
words.my_none?(5) == words.none?(5)

# my_map

my_proc = proc { |num| num > 10 }

# Expectation

array.my_map(&my_proc) { |num| num < 10 } == array.map(&my_proc)

# my_inject

search = proc { |memo, word| memo.length > word.length ? memo : word }

# Expectation

words.my_inject(&search) == words.inject(&search)

array_clone = array.clone
array.my_inject { |num| num + 1 } # After calling my_inject on it

# Expectation

array == array_clone

operation = proc { |sum, n| sum + n }

# Expectation

array.my_inject(&operation) == array.inject(&operation)

actual = range.my_inject { |prod, n| prod _ n }
expected = range.inject { |prod, n| prod _ n }

# Expectation

actual == expected

actual = range.my_inject(4) { |prod, n| prod _ n }
expected = range.inject(4) { |prod, n| prod _ n }
actual == expected

array.my_inject(:+) == array.inject(:+)

range.my_inject(:_) == range.inject(:_)

array.my_inject(20, :_) == array.inject(20, :_)

range.my_inject(2, :_) == range.inject(2, :_)

#multiply_els?
multiply_els [2, 4, 5] == 40
