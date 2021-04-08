require_relative '../enumerables'
require 'rspec'
# To Run "rspec spec/spec_enumerables.rb"

describe 'Enumerables' do
  let(:arr) { [1, 2, 3, 4, 5] }
  let(:negative) { [1, -2, 3, 4] }
  let(:same_array) { [1, 1, 1, 1] }
  let(:false_array) { [false] }
  let(:empty_array) { [] }
  
  describe 'my_each method' do
    it 'when no block it should return Enumerable' do
        expect(arr.my_each).to be_a(Enumerable)
    end

    it 'when block given then should execute the block for each element' do
        arr2=[]
        arr.my_each { |ele| arr2 << ele }
        expect(arr2).to eq(arr)
      end

      it 'when block given then should return self with same object' do
        arr = [1, 1, 1]
        expect(arr.my_each { |ele| ele }).to be(arr)
      end
  end

  describe 'my_each_with _index method' do
    it 'when no block it should return Enumerable' do
        expect(arr.my_each_with_index).to be_a(Enumerable)
    end     
  end

  describe 'my_select method' do
    it 'when no block it should return Enumerable' do
        expect(arr.my_select).to be_a(Enumerable)
    end

    it 'when block given then should return array which satisfy condition' do
        arr2 = [3,4,5]
        arr3=arr.my_select { |ele| ele > 2 }
        expect(arr3).to eq(arr2)
    end 

    it 'when false given in block then return empty array' do        
        arr3=arr.my_select { |ele| false }
        expect(arr3).to eq(empty_array)
    end      
  end

 

  describe 'my_all? method' do
    it 'when no block it should return true' do
        expect(arr.my_all?).to be true
    end

    it 'should return true if empty array' do
        expect(empty_array.my_all?).to be true
    end

    it 'when block given then should return true if all element satisfy the condition' do   
        expect(arr.my_all? { |ele| ele > 0}).to be true
    end 

    it 'when parameter given then should return true if all element satisfy the condition' do
        expect([1,2,3,4].my_all? { |ele| ele > 0}).to be true
    end

    it 'when block given then should return false if any one of element not satisfy the condition' do
        expect(arr.my_all? { |ele| ele > 4}).not_to be true
    end 
    
    it 'when parameter given then should return false if any one of element not satisfy the condition' do
        expect([1,2,3,4].my_all? { |ele| ele == 4}).not_to be true
    end

    it 'when parameter given then should return false if any one of element doesntsatisfy the condition' do
        expect([1, 2.91, 3, 4].my_all?(Float)).not_to be true
    end
    
    it 'when null is an element it should return false' do
        expect([1,2,3,nil].my_all?).not_to be true
    end
    it 'when false is an element it should return false' do
        expect(false_array.my_all?).not_to be true
    end
  end



  describe 'my_any? method' do
    it 'when no block it should return true if element in the array' do
        expect(arr.my_any?).to be true
    end

    it 'when all element is true should return true' do
        expect([1,2,3,nil].my_any?).to be true
    end
 
    it 'when block given then should return true if any element satisfy condition' do   
        expect(arr.my_any? { |ele| ele > 2}).to be true
    end 

    it 'when parameter given then should return true if any one of element satisfy the condition' do
        expect([1,2,3,4].my_any? { |ele| ele == 4}).to be true
    end

    it 'when parameter given then should return true if any one of element satisfy the condition' do
        expect([1, 2.91, 3, 4].my_any?(Float)).to be true
    end

    it 'should return false if empty array' do
        expect(empty_array.my_any?).not_to be true
    end    

    it 'when block given then should return false if all element not satisfy the condition' do
        expect(arr.my_any?{ |ele| ele > 10}).not_to be true
    end 

    it 'when parameter given then should return false if all of element not satisfy the condition' do
        expect([1,2,3,4].my_any? { |ele| ele > 5}).not_to be true
    end
    
  end

  describe 'my_none? method' do
    it 'when null and false is an element it should return true' do
        expect(false_array.my_none?).to be true
    end

    it 'should return true if empty array' do
        expect(empty_array.my_none?).to be true
    end

    it 'when block given then should return true if no element satisfy the condition' do   
        expect(arr.my_none? { |ele| ele < 0}).to be true
    end 

    it 'when parameter given then should return true if no element satisfy the condition' do
        expect([1,2,3,4].my_none? { |ele| ele < 0}).to be true
    end

    it 'when block given then should return false if any one of element satisfy the condition' do
        expect(arr.my_none? { |ele| ele == 4}).not_to be true
    end   
    
    it 'when parameter given then should return false if any one of element satisfy the condition' do
        expect([1, 2.91, 3, 4].my_none?(Float)).not_to be true
    end 
  end

  
  

end
