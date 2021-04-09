require_relative '../enumerables'
require 'rspec'
# To Run "rspec spec/enumerables_spec.rb"

describe 'Enumerables' do
  let(:arr) { [1, 2, 3, 4, 5] }
  let(:false_array) { [false] }
  let(:empty_array) { [] }

  describe 'my_each method' do
    it 'when no block it should return Enumerator' do
      expect(arr.my_each).to be_a(Enumerator)
    end

    it 'when block given then should execute the block for each element' do
      arr2 = []
      arr.my_each { |ele| arr2 << ele }
      expect(arr2).to eq(arr)
    end

    it 'when block given then should return self with same object' do
      arr = [1, 1, 1]
      expect(arr.my_each { |ele| ele }).to be(arr)
    end
  end

  describe 'my_each_with _index method' do
    it 'when no block it should return Enumerator' do
      expect(arr.my_each_with_index).to be_a(Enumerator)
    end
  end

  describe 'my_select method' do
    it 'when no block it should return Enumerator' do
      expect(arr.my_select).to be_a(Enumerator)
    end

    it 'when block given then should return array which satisfy condition' do
      arr2 = [3, 4, 5]
      arr3 = arr.my_select { |ele| ele > 2 }
      expect(arr3).to eq(arr2)
    end

    it 'when false given in block then return empty array' do
      arr3 = arr.my_select { |_ele| false }
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
      expect(arr.my_all? { |ele| ele > 0 }).to be true
    end

    it 'when parameter given then should return true if all element satisfy the condition' do
      expect([1, 2, 3, 4].my_all? { |ele| ele > 0 }).to be true
    end

    it 'when block given then should return false if any one of element not satisfy the condition' do
      expect(arr.my_all? { |ele| ele > 4 }).not_to be true
    end

    it 'when parameter given then should return false if any one of element not satisfy the condition' do
      expect([1, 2, 3, 4].my_all? { |ele| ele == 4 }).not_to be true
    end

    it 'when parameter given then should return false if any one of element doesntsatisfy the condition' do
      expect([1, 2.91, 3, 4].my_all?(Float)).not_to be true
    end

    it 'when null is an element it should return false' do
      expect([1, 2, 3, nil].my_all?).not_to be true
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
      expect([1, 2, 3, nil].my_any?).to be true
    end

    it 'when block given then should return true if any element satisfy condition' do
      expect(arr.my_any? { |ele| ele > 2 }).to be true
    end

    it 'when parameter given then should return true if any one of element satisfy the condition' do
      expect([1, 2, 3, 4].my_any? { |ele| ele == 4 }).to be true
    end

    it 'when parameter given then should return true if any one of element satisfy the condition' do
      expect([1, 2.91, 3, 4].my_any?(Float)).to be true
    end

    it 'should return false if empty array' do
      expect(empty_array.my_any?).not_to be true
    end

    it 'when block given then should return false if all element not satisfy the condition' do
      expect(arr.my_any? { |ele| ele > 10 }).not_to be true
    end

    it 'when parameter given then should return false if all of element not satisfy the condition' do
      expect([1, 2, 3, 4].my_any? { |ele| ele > 5 }).not_to be true
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
      expect(arr.my_none? { |ele| ele < 0 }).to be true
    end

    it 'when parameter given then should return true if no element satisfy the condition' do
      expect([1, 2, 3, 4].my_none? { |ele| ele < 0 }).to be true
    end

    it 'when block given then should return false if any one of element satisfy the condition' do
      expect(arr.my_none? { |ele| ele == 4 }).not_to be true
    end

    it 'when parameter given then should return false if any one of element satisfy the condition' do
      expect([1, 2.91, 3, 4].my_none?(Float)).not_to be true
    end
  end

  describe 'my_count method' do
    it 'return length of array' do
      expect(arr.my_count).to eq(arr.length)
    end

    it 'return the count of the repeated element' do
      arr1 = [1, 2, 2, 3, 2]
      expect(arr1.my_count(2)).to eq(3)
    end

    it 'return the count of the odd element' do
      arr1 = [1, 2, 2, 3, 2]
      expect(arr1.my_count(&:odd?)).to eq(2)
    end

    it 'return the count of the repeated element' do
      expect(empty_array.my_count).to eq(0)
    end
  end

  describe 'my_map method' do
    it 'when no block it should return Enumerator' do
      expect(arr.my_map).to be_a(Enumerator)
    end

    it 'should return the array after calculation with each element' do
      arr1 = [3, 4, 5]
      arr2 = [6, 8, 10]
      arr3 = arr1.my_map { |ele| ele * 2 }
      expect(arr3).to eq(arr2)
    end

    it 'should returns thearray with all elements in upper case' do
      expect(%w[Deepak].my_map(&:upcase)).to eql(%w[DEEPAK])
    end

    it 'should returns ehe array with all elements converted to integrs' do
      expect(%w[1 2 3 4 5].my_map(&:to_i)).to eql([1, 2, 3, 4, 5])
    end

    it 'should returns the class of each element in the given array' do
      expect([10, 'sweet', :a].my_map(&:class)).to eql([Integer, String, Symbol])
    end
  end

  describe 'my_inject method' do
    it 'Returns local jump error if no block given' do
      expect { arr.my_inject }.to raise_error(LocalJumpError)
    end

    it 'should return the sum' do
      arr2 = [5, 6, 7, 8, 9, 10]
      arr3 = arr2.my_inject { |sum, n| sum + n }
      expect(arr3).to eq(45)
    end

    it 'should return the product' do
      arr2 = [5, 6, 7, 8, 9, 10]
      arr3 = arr2.my_inject(1) { |product, n| product * n }
      expect(arr3).to eq(151_200)
    end

    it 'should return the longest word' do
      longest = %w[cat sheep bear]
      long_word = longest.my_inject { |memo, word| memo.length > word.length ? memo : word }
      expect(long_word).to eq('sheep')
    end

    it 'should return the sum of all element' do
      expect((1..4).my_inject(:+)).to eql(10)
    end
  end

  describe 'multiply_els method' do
    it 'returns result from multiply_els method' do
      expect(multiply_els(1..5)).to eq(120)
    end
  end
end
