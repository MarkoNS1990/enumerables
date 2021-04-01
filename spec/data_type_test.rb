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

describe '#my_select' do
  let(:array) { Array.new(100) { rand(0...9) } }
  let(:words) { %w[dog door rod blade] }  
  
  it 'should return true if all elements are of Integer type' do
    expect(array.my_all?(Integer) == array.all?(Integer)).to eql(true)
  end

  it 'should return true if all elements are of Numeric type' do
    expect(array.my_all?(Numeric) == array.all?(Numeric)).to eql(true)
  end

  it 'regex1' do 
    
    expect(words.my_all?(/d/) == words.all?(/d/)).to eql(true)
  end

  it 'regex2' do 
    
    expect(words.my_all?(/o/) == words.all?(/o/)).to eql(true)
  end


end

end
