require_relative '../enumerable_methods'

describe Enumerable do
  describe '#my_each' do
    it 'Returns an enumerable when no block is given' do
      expect([1,2,3].my_each).to be_a(Enumerable)
    end
    context 'when block is given' do
      it 'Returns the range of numbers passed when range is given' do
        expect((1..3).my_each {|a| a}).to eql(1..3)
      end

      it 'Returns the key-value pair of an Hash passed into it ' do
        expect({x: 1, y: 2}.my_each {|a| a}).to eql({:x =>1, :y=> 2})
      end

      it 'Returns the exact array passed into it' do
        expect([1, 2, "a", "b"].my_each {|a| a}).to eql([1, 2, "a", "b"])
      end
    end
  end
end
