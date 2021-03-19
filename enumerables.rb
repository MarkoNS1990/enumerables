module Enumerable
    def my_each
        i = 0  #iterator
        while  i < self.length
            yield self[i]
            i+=1
        end
    end
end

#my_each
['a','b',3,'d'].my_each{|i| puts i}