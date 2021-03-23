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

  def my_any?(item1 = nil)
    if block_given?
      my_each { |i| return true if yield(i) }
      return false
    elsif item1.nil?
      my_each { |i| return true if i }
    elsif !item1.nil? && (item1.is_a? Class)
      my_each { |i| return true if i.is_a?(item1) }
    elsif !item1.nil? && item1.instance_of?(Regexp)
      my_each { |i| return true if item1.match(i) }
    else
      my_each { |i| return true if i == item1 }
    end
    false
  end

  def my_none?(item1 = nil)
    if block_given? && !item1
      my_each { |i| return false unless yield(i) == false }
      return true
    elsif item1.nil?
      my_each { |i| return true if i.nil? || i == true }
    elsif item1.is_a? Class
      my_each { |i| return true unless i.is_a?(item1) }
      return false
    elsif !item1.nil? && item1.instance_of?(Regexp)
      my_each { |i| return true unless item1.match(i) }
    else
      my_each { |i| return true if i != item1 }
    end
    false
  end

  def my_count(items1 = nil)
    if items1
      selected = my_select { |i| i == items1 }
      selected.size
    else
      return to_a.size unless block_given?

      a = 0

      my_each do |i|
        yield(i) && a += 1
      end
      a
    end
  end

  def my_map(items1 = nil)
    return to_enum if !block_given? && !items1

    items = clone.to_a
    items.my_each_with_index do |item, i|
      items[i] = if items1
                   items1.call(item)
                 else
                   yield item
                 end
    end
    items
  end

  def my_inject(value = nil, symbol = nil)
    if (!value.nil? && symbol.nil?) && (value.is_a?(Symbol) || value.is_a?(String))
      symbol = value
      value = nil
    end

    raise LocalJumpError, 'no block given' if !block_given? && symbol.nil? && value.nil?

    if block_given? && symbol.nil?
      to_a.my_each { |item| value = value.nil? ? item : yield(value, item) }
    else

      to_a.my_each { |item| value = value.nil? ? item : value.send(symbol, item) }
    end
    value
  end
end

def multiply_els(arr)
  arr.my_inject(:*)
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
# arr2=[12, 16, 17, 18].my_any? { |num| num > 20 } # False
# p arr2
# # my_none
# variable = [11,22,21,12,34].my_none? { |num| num < 15 } #
# puts variable
# # my_count
# count = [12, 16, 17, 18, 20, 22, 23].my_count { |num| num <17 } # 4
# puts count
# # my_map
# new_arr2 = [13, 15, 18, 19].my_map { |num| num + 1 } # [14,16,19,20]
# p new_arr2
# # my_inject
# [1, 2, 3].my_inject { |sum, num| sum + num } # result = 6
# [1,2,3].my_inject # error - no block given
# puts multiply_els([2, 4, 5]) # 40
