require_relative '../enumerables'

describe '#my_select' do
  it 'should return true if block returns false or nil' do
    expect([1, 2, 3, 4, 5].my_select(&:odd?) == [1, 2, 3, 4, 5].select(&:odd?)).to eql(true)
  end
end
