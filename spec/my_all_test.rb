require_relative '../enumerables'

describe '#my_all' do
  let(:range) { Range.new(5, 50) }
  let(:true_block) { proc { |num| num <= 9 } }
  let(:false_block) { proc { |num| num > 9 } }
  let(:words) { %w[dog door rod blade] }
  let(:array) { Array.new(100) { rand(0...9) } }

  it 'should return true if block never returns false or nil' do
    expect(array.my_all?(&true_block) == array.all?(&true_block)).to eql(true)
  end

  it 'should return true if block returns false or nil' do
    expect(array.my_all?(&false_block) == array.all?(&false_block)).to eql(true)
  end

  it 'should return true if block returns false or nil:range ' do
    expect(range.my_all?(&false_block) == range.all?(&false_block)).to eql(true)
  end
end
