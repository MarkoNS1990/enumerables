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

    def my_select
        newArr = []
        i=0
        while i < self.length
            newArr << self[i] if yield  self[i]
                i+=1
        end
     newArr
    end

    def my_all?
        self.my_each do |num|
            return false unless yield (num)
        end
        return true        
    end

    def my_any?
        variable = 0
        self.my_each do |num|
            variable+=1 if yield num           
        end
        puts true if variable > 0
        puts false if variable == 0
    end

    def my_none?
        self.my_each do |num|
            return false if yield (num)
        end
        return true  

    end

    def my_count
        arr=[]
        self.my_each do |num|
            arr << num if yield (num)
        end
        return arr.length
    end
end

#my_each
# ['a','b',3,'d'].my_each{|i| puts i}
#my_each_with_index
# ['a','b',3,'d'].my_each_with_index{|i, index| p i, index}
#my_select
# myArray = [1,3,4,10,8].my_select {|num| num > 3}  #[4,10,8]
# p myArray
#my_all
# [12,16,17,18,19].my_all? {|num| puts num > 10}  #true
#my_any
# [12,16,17,18].my_any? {|num| num > 20}  #False
#my_none
# variable =[12,16,17,18].my_none? {|num| num > 17} # 
# puts variable
# my_count
count=[12,16,17,18,20,22,23].my_count {|num| num > 17}  #4
puts count