# rubocop: disable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity,Metrics/ModuleLength
module Enumerable
  def my_each
    return to_enum unless block_given?

    i = 0 # iterator
    while i < to_a.length
      yield to_a[i]
      i += 1
    end
    self
  end

  def my_each_with_index
    return to_enum unless block_given?

    i = 0
    while i < to_a.length
      yield to_a[i], i
      i += 1
    end
    self
  end

  def my_select
    return to_enum unless block_given?

    new_arr = []
    i = 0
    while i < to_a.length
      new_arr << to_a[i] if yield to_a[i]
      i += 1
    end
    new_arr
  end

  def my_all?(item1 = nil)
    if block_given? && !item1
      to_a.my_each { |i| return false if yield(i) == false }
      return true
    elsif item1.nil?
      to_a.my_each { |i| return false if i.nil? || i == false }
    elsif item1.is_a? Class
      to_a.my_each { |i| return false unless i.is_a?(item1) }
      return true
    elsif !item1.nil? && item1.instance_of?(Regexp)
      to_a.my_each { |i| return false unless item1.match(i) }
    else
      to_a.my_each { |i| return false if i != item1 }
    end
    true
  end

  def my_any?(item1 = nil)
    if block_given?
      to_a.my_each { |i| return true if yield(i) }
      return false
    elsif item1.nil?
      to_a.my_each { |i| return true if i }
    elsif !item1.nil? && (item1.is_a? Class)
      to_a.my_each { |i| return true if i.is_a?(item1) }
    elsif !item1.nil? && item1.instance_of?(Regexp)
      to_a.my_each { |i| return true if item1.match(i) }
    else
      to_a.my_each { |i| return true if i == item1 }
    end
    false
  end

  def my_none?(item1 = nil)
    if block_given?
      !my_any?(&Proc.new)
    else
      !my_any?(item1)
    end
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

# rubocop: enable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity,Metrics/ModuleLength
