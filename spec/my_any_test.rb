require_relative '../enumerables'

describe '#my_any' do
    let(:words) { %w[dog door rod blade] }
    let(:array) { Array.new(100) { rand(0...9) } }
    let(:range) { Range.new(5, 50) }
    let(:true_block) { proc { |num| num <= 9 } }
    let(:false_block) { proc { |num| num > 9 } }
    let(:false_array) {[1, false, 'hi', []]}

    it 'should return true if block returns false or nil' do
        expect(array.my_any?(&false_block) == array.any?(&false_block)).to eql(true)
    end

    it 'should return true if block returns false or nil:range' do
        expect(range.my_any?(&false_block) == range.any?(&false_block)).to eql(true)
    end

    it 'should return true if any of elements of an array are false' do
        expect(false_array.my_any? == false_array.any?).to eql(true)
    end

    it 'should return true if any of elements of an array are type of Integer' do
        expect(words.my_any?(Integer) == words.any?(Integer)).to eql(true)
    end

    it 'should return true when regex is passed as an argument if any of the collection matches the regex' do
        expect(words.my_any?(/z/) == words.any?(/z/)).to eql(true)
    end

    it 'should return true when string is passed as an argument if any of the collection matches the given string' do
        expect(words.my_any?('cat') == words.any?('cat')).to eql(true)
    end

end