module Enumerable
    def my_each
        i = 0  #iterator
        while  i < self.length
            yield self[i]
            i+=1
        end
    end

    def my_each_with_index
        i = 0
        while i < self.length
            yield self[i], i
            i += 1
        end
    end
end

#my_each
['a','b',3,'d'].my_each{|i| puts i}
#my_each_with_index
['a','b',3,'d'].my_each_with_index{|i, index| p i, index}