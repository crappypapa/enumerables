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

  describe '#my_each_with_index' do
    it 'Returns an enumerable when no block is given' do
      expect([1,2,3].my_each_with_index).to be_a(Enumerable)
    end
  end

  describe '#my_select' do
    it 'Returns an enumerable when no block given' do
      expect((1..3).my_select).to be_a(Enumerable)
    end

    context 'When block is given' do
      it 'Returns an array of the given range passed' do
        expect((1..3).my_select { |el| el }).to eq([1, 2, 3])
      end

      it 'selects and return the even numbers from an array of numbers' do
        expect((1..10).my_select(&:even?)).to eq([2, 4, 6,8,10])
      end

      it 'selects strings with length greater or equal to 3 than ' do
        expect(%w[I am twice as tall as Olaoluwa].my_select { |el| el.length >= 3 }).to eq(%w[twice tall Olaoluwa])
      end
    end
  end

  describe '#my_all?' do
    it 'Returns true if self is empty' do
      expect([].my_all?).to eql(true)
    end

    it 'Returns false if self is not empty' do
      expect([nil].my_all?).to eql(false)
    end

    it 'returns true if all of numbers is less than 10 in the given array' do
      expect([1, 5, 7].my_all? { |el| el < 10 }).to be(true)
    end

    it 'returns false if all of numbers is not greater than 20 in the given array' do
      expect([26, 25, 14].my_all? { |el| el > 20 }).to_not eql(true)
    end

    it 'returns false if none of the words has the "a" character ' do
      expect(%w[I am a software developer].my_all?(/a/)).to_not eql(true)
    end

    it 'returns true if all of the words has the b characte ' do
      expect(%w[professional software developer].my_all?(/e/)).to eql(true)
    end

    it 'retrns false if none of the hash values is an odd number' do
      expect({ a: 10, b: 4, c: 8}.my_all? { |_k, v| v.odd? }).to eq(false)
    end

    it 'retrns true if all of the hash values is an odd number' do
      expect({ a: 3, b: 5, c: 7 }.my_all? { |_k, v| v.odd? }).to eq(true)
    end
  end
end