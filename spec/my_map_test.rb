require_relative '../enumerables'

describe '#my_map' do
  let(:my_proc) { proc { |num| num > 10 } }
  let(:array) { Array.new(100) { rand(0...9) } }

  it 'should return true if block given' do
    expect(array.my_map(&my_proc) == array.map(&my_proc)).to eql(true)
  end
end
