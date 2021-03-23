module Enumerable
  def my_each
    return to_enum unless block_given?

    i = 0 # iterator
    while i < length
      yield self[i]
      i += 1
    end
    self
  end

  def my_each_with_index
    return to_enum unless block_given?

    i = 0
    while i < length
      yield self[i], i
      i += 1
    end
    self
  end

  def my_select
    return to_enum unless block_given?

    new_arr = []
    i = 0
    while i < length
      new_arr << self[i] if yield self[i]
      i += 1
    end
    new_arr
  end

  def my_all?(item1 = nil)
    if block_given? && !item1
      my_each { |i| return false if yield(i) == false }
      return true
    elsif item1.nil?
      my_each { |i| return false if i.nil? || i == false }
    elsif item1.is_a? Class
      my_each { |i| return false unless i.is_a?(item1) }
      return true
    elsif !item1.nil? && item1.instance_of?(Regexp)
      my_each { |i| return false unless item1.match(i) }
    else
      my_each { |i| return false if i != item1 }
    end
    true
  end

  def my_any?
    variable = 0
    my_each do |num|
      variable += 1 if yield num
    end
    puts true if variable.positive?
    puts false if variable.zero?
  end

  def my_none?
    my_each do |num|
      return false if yield num
    end
    true
  end

  def my_count
    arr = []
    my_each do |num|
      arr << num if yield num
    end
    arr.length
  end

  def my_map(&proc1)
    new_arr = []
    if block_given?
      my_each do |el|
        new_arr << yield(el)
      end
    else
      my_each do |el|
        new_arr << proc1.call(el)
      end
    end
    new_arr
  end

  def my_inject
    result = self[0] # Start value for result
    (1...length).each do |i| # Iterate through array
      result = yield(result, self[i]) # Result gets new value - result=result + current num
    end
    result
  end
end

def multiply_els(arr)
  arr.my_inject { |a, b| a * b }
end

# # my_each
# p ['a', 'b', 3, 'd'].my_each {|num|  num}
# p ['a', 'b', 3, 'd'].my_each # return enum if no block
# # my_each_with_index
# ['a', 'b', 3, 'd'].my_each_with_index { |i, index| p i, index }
# # my_select
# my_array1 = [1, 3, 4, 10, 8].my_select { |num| num > 3 } # [4,10,8]
# p my_array1
# my_all
# arr1=[nil,18].my_all? { |num|  num == 18  } # false
# p arr1
# my_any
[12, 16, 17, 18].my_any? { |num| num > 20 } # False
# # my_none
# variable = [12, 16, 17, 18].my_none? { |num| num > 17 } #
# puts variable
# # my_count
# count = [12, 16, 17, 18, 20, 22, 23].my_count { |num| num > 17 } # 4
# puts count
# # my_map
# new_arr2 = [13, 15, 18, 19].my_map { |num| num + 1 } # [14,16,19,20]
# p new_arr2
# # my_inject
# result = [1, 2, 3].my_inject { |sum, num| sum + num } # result = 6
# puts result
# puts multiply_els([2, 4, 5]) # 40
