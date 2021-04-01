require_relative '../enumerables'

describe '#my_inject' do
  let(:search) { proc { |memo, word| memo.length > word.length ? memo : word } }
  let(:words) { %w[dog door rod blade] }
  let(:array) { Array.new(100) { rand(0...9) } }
  let(:range) { Range.new(5, 50) }

  it 'search for the longest word in array of strings' do
    expect(words.my_inject(&search) == words.inject(&search)).to eql(true)
  end

  it 'check if original array is not mutated ' do
    array_clone = array.clone
    array.my_inject { |num| num + 1 }
    expect(array == array_clone).to eql(true)
  end

  it 'when a block is given without initial value it combines all elements of enum, apply binary spc by block' do
    operation = proc { |sum, n| sum + n }
    expect(array.my_inject(&operation) == array.inject(&operation)).to eql(true)
  end

  it 'when a block is given without initial value it combines all elements of enum, apply binary spc by block:range' do
    actual = range.my_inject { |prod, n| prod * n }
    expected = range.inject { |prod, n| prod * n }
    expect(actual == expected).to eql(true)
  end

  it 'when a symbol is given without initial value it combines all elements of enum, apply binary spc b named method' do
    expect(array.my_inject(:+) == array.inject(:+)).to eql(true)
  end

  it 'when a symbol is given without initial value it combines all elements of enum, apply binary spc b named method' do
    expect(array.my_inject(:*) == array.inject(:*)).to eql(true)
  end

  it ' when a sym is specified with an initial value, sym as named method ' do
    expect(array.my_inject(20, :*) == array.inject(20, :*)).to eql(true)
  end

  it ' when a sym is specified with an initial value: sym as named methid range ' do
    expect(range.my_inject(2, :*) == range.inject(2, :*)).to eql(true)
  end
end
