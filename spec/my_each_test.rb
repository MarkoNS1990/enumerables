require_relative '../enumerables'

describe '#my_each_with_index' do
    it 'should check each element of an array' do
        
        expect(['aca','marijan','marko'].my_each_with_index {|x| p x != 'aca'} == ['aca','marijan','marko'].each_with_index {|x| p x != 'aca'}).to eql(true)
    end
end