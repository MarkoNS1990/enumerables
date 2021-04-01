require_relative '../enumerables'

describe '#my_each' do
  it 'should return true if it is an Enumerable' do
    expect([1, 2, 3].my_each.instance_of?(Enumerator)).to eql(true)
  end
end

describe '#my_each_with_index' do
  it 'should return true if it is an Enumerable' do
    expect([1, 2, 3].my_each_with_index.instance_of?(Enumerator)).to eql(true)
  end
end

describe '#my_select' do
  it 'should return true if it is an Enumerable' do
    expect([1, 2, 3].my_select.instance_of?(Enumerator)).to eql(true)
  end
end
