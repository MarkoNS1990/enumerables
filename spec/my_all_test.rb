require_relative '../enumerables'

describe '#my_all' do
  let(:range) { Range.new(5, 50) }
  let(:true_block) { proc { |num| num <= 9 } }
  let(:false_block) { proc { |num| num > 9 } }
  let(:words) { %w[dog door rod blade] }
  let(:array) { Array.new(100) { rand(0...9) } }
  let(:true_array) { [1, true, 'hi', []] }
  let(:false_array) { [1, false, 'hi', []] }

  it 'should return true if block never returns false or nil' do
    expect(array.my_all?(&true_block) == array.all?(&true_block)).to eql(true)
  end

  it 'should return true if block returns false or nil' do
    expect(array.my_all?(&false_block) == array.all?(&false_block)).to eql(true)
  end

  it 'should return true if block returns false or nil:range' do
    expect(range.my_all?(&false_block) == range.all?(&false_block)).to eql(true)
  end

  it 'should return true if all elements of an array are true' do
    expect(true_array.my_all? == true_array.all?).to eql(true)
  end

  it 'should return true if any of elements of an array are false' do
    expect(false_array.my_all? == false_array.all?).to eql(true)
  end

  it 'must return true when regex is passed as an argument all of the collection matches the regex' do
    expect(words.my_all?(/d/) == words.all?(/d/)).to eql(true)
  end

  it 'must return true when regex is passed as an argument all of the collection does not match the regex' do
    expect(words.my_all?(/o/) == words.all?(/o/)).to eql(true)
  end

  it 'pattern other than regex or class given return true if all collection matches the pattern of local var' do
    array = []
    10.times { array << 3 }
    expect(array.my_all?(3) == array.all?(3)).to eql(true)
  end

  it 'pattern other than regex or class given return true if all collection matches the pattern of global var' do
    expect(array.my_all?(3) == array.all?(3)).to eql(true)
  end
end
