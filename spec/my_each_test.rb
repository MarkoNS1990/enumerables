require_relative '../enumerables'

describe '#my_each_with_index' do
  it 'should check each element of an array' do
    expect(%w[aca marijan marko].my_each_with_index do |x|
             p x != 'aca'
           end == %w[aca marijan marko].each do |x|
                    p x != 'aca'
                  end).to eql(true)
  end
end
