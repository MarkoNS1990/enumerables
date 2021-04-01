require_relative '../enumerables'

describe '#my_any' do
    let(:words) { %w[dog door rod blade] }
    let(:array) { Array.new(100) { rand(0...9) } }
    let(:range) { Range.new(5, 50) }
    let(:true_block) { proc { |num| num <= 9 } }
    let(:false_block) { proc { |num| num > 9 } }
    let(:true_array) { [1, true, 'hi', []] }
    

    it 'should return true if block never returns false or nil' do
        expect(array.my_none?(&true_block) == array.none?(&true_block)).to eql(true)
    end

    it 'should return true if block never returns false or nil:range' do
        expect(range.my_none?(&false_block) == range.none?(&false_block)).to eql(true)
    end

    it 'should return true if all of elements of an array are true' do
        expect(true_array.my_none? == false).to eql(true)
    end

    it 'should return true when regex is passed as an argument if none of the collection matches the regex' do
        expect(words.my_none?(/z/) == words.none?(/z/)).to eql(true)
    end

    it 'should return true when number is passed as an argument if none of the collection includes number' do
        expect(words.my_none?(5) == words.none?(5)).to eql(true)
    end

    

end