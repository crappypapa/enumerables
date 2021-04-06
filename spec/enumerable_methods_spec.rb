require_relative '../enumerable_methods'

describe Enumerable do
  describe '#my_each' do
    it 'Returns an enumerable when no block is given' do
      expect([1, 2, 3].my_each).to be_a(Enumerable)
    end
    context 'when block is given' do
      it 'Returns the range of numbers passed when range is given' do
        expect((1..3).my_each { |a| a }).to eql(1..3)
      end

      it 'Returns the key-value pair of an Hash passed into it ' do
        expect({ x: 1, y: 2 }.my_each { |a| a }).to eql({ x: 1, y: 2 })
      end

      it 'Returns the exact array passed into it' do
        expect([1, 2, 'a', 'b'].my_each { |a| a }).to eql([1, 2, 'a', 'b'])
      end
    end
  end

  describe '#my_each_with_index' do
    it 'Returns an enumerable when no block is given' do
      expect([1, 2, 3].my_each_with_index).to be_a(Enumerable)
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
        expect((1..10).my_select(&:even?)).to eq([2, 4, 6, 8, 10])
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
      expect({ a: 10, b: 4, c: 8 }.my_all? { |_k, v| v.odd? }).to eq(false)
    end

    it 'retrns true if all of the hash values is an odd number' do
      expect({ a: 3, b: 5, c: 7 }.my_all? { |_k, v| v.odd? }).to eq(true)
    end
  end

  describe '#my_any?' do
    it 'Returns false if self is empty' do
      expect([].my_any?).to_not be(true)
    end

    it 'Returns true if self is not empty' do
      expect([1, 'a'].my_any?).to be(true)
    end

    it 'returns true if any number is greater than five in the given array' do
      expect([2, 6, 4].my_any? { |el| el > 3 }).to be(true)
    end
    it 'returns false if any number is less than three in the given array' do
      expect([4, 5, 6].my_any? { |el| el < 3 }).to be(false)
    end
    it 'returns true if length of any word is greater than 3 ' do
      expect(%w[I love software development].my_any? { |el| el.length > 3 }).to be(true)
    end
    it 'returns false if there is no length of any word lesser than 3 chracters ' do
      expect(%w[software development cannot get more exciting].my_any? { |el| el.length < 3 }).to be(false)
    end

    it 'returns false if any word given is of Class STRING ' do
      expect(['felix', 1].my_any?(String)).to be(true)
    end
    it 'returns false if there is no STRING in array given ' do
      expect([1, :shaher, nil].my_any?(String)).to be(false)
    end

    it 'retrns true if any of the hash values is an odd number' do
      expect({ a: 2, b: 3, c: 4 }.my_any? { |_keys, value| value.odd? }).to eq(true)
    end
    it 'retrns false if none of the hash values is greater than 5' do
      expect({ a: 2, b: 3, c: 4 }.my_any? { |_keys, value| value > 5 }).to eq(false)
    end
    it 'returns true if the "!" character exists in the string ' do
      expect(%w[I enjoy coding!].my_any?(/!/)).to be(true)
    end
    it 'returns false if the b character does not exist in the string ' do
      expect(%w[I enjoy coding!].my_any?(/b/)).to be(false)
    end
  end

  describe '#my_none?' do
    it 'Returns true if self is empty' do
      expect([].my_none?).to be(true)
    end

    it 'Returns false if self is not empty' do
      expect([1, 2].my_none?).to be(false)
    end

    it 'returns true if none of numbers is lesser than 10 in the given array' do
      expect([11, 12, 14].my_none? { |el| el < 10 }).to_not be(false)
    end

    it 'returns true if none of numbers is greater than 20 in the given array' do
      expect([11, 12, 14].my_none? { |el| el > 20 }).to be(true)
    end

    it 'returns true if none of the elements is lesser than 3 chracters ' do
      expect(%w[sleeping beauty].my_none? { |el| el.length < 3 }).to be(true)
    end

    it 'returns true if none of words is greater than 3 chracters ' do
      expect(%w[a is b to c].my_none? { |el| el.length > 3 }).to be(true)
    end

    it 'returns false if any word less than 3 chracters ' do
      expect(%w[I am a boy].my_none?(String)).to be(false)
    end
    it 'returns false if none of the words is a STRING ' do
      expect([1, :a, nil].my_none?(String)).to be(true)
    end

    it 'retrns true if none of the hash values is an odd number' do
      expect({ a: 2, b: 4, c: 6 }.my_none? { |_k, v| v.odd? }).to eq(true)
    end
    it 'retrns false if any of the hash values is an even number' do
      expect({ a: 2, b: 3, c: 4, d: 5 }.my_none? { |_k, v| v.even? }).to eq(false)
    end
    it 'returns true if none of the words has the "e" character ' do
      expect(%w[I am a boy].my_none?(/e/)).to_not be(false)
    end
    it 'returns false if any of the words has the "a" characte ' do
      expect(%w[I am a boy].my_none?(/a/)).to_not be(true)
    end
  end

  describe '#my_count' do
    it 'counts the even numbers in a given array' do
      expect([1, 2, 3, 4, 5].my_count(&:even?)).to be(2)
    end

    it 'counts the words in a string that is longer than 4 characters ' do
      expect(%w[Twice as tall is a grammy album].my_count { |el| el.length > 4 }).to be(3)
    end

    it 'counts the number of hash values that are odd number' do
      expect({ a: 1, b: 2, c: 3, d: 4 }.my_count { |_k, v| v.odd? }).to eq(2)
    end

    it 'counts the number of words has the "e" character ' do
      expect(%w[short and tall is a grammy album].my_count(/e/)).to be(0)
    end

    it 'counts the number of times the number two appears in the array ' do
      expect([1, 2, 2, 4, 3, 3].my_count(2)).to be(2)
    end

    it 'counts the number of the words in a given array ' do
      expect(%w[Twice as tall is a grammy album].my_count { |word| word.count(word) }).to be(7)
    end

    it 'counts the number of the elements in the array ' do
      expect([1, 2, 3].my_count).to be(3)
    end
  end

  describe '#my_map' do
    it 'Returns Enumerable if the given array is empty' do
      expect([].my_map).to be_a(Enumerable)
    end

    it 'returns a new array with all elements in upper case' do
      expect(%w[olaoluwa soladoye].my_map(&:upcase)).to eql(%w[OLAOLUWA SOLADOYE])
    end

    it 'returns a new array with the number multiplied by 2' do
      expect([3, 5, 7].my_map { |n| n * 2 }).to eql([6, 10, 14])
    end

    it 'returens the hash values conveted into symbols' do
      expect({ bacon: 'protein', apple: 'fruit' }.my_map do |k, v|
               [k, v.to_sym]
             end.to_h).to eql({ bacon: :protein, apple: :fruit })
    end

    it 'returns the class of each element in the given array' do
      expect([10, 'sweet', :a].my_map(&:class)).to eql([Integer, String, Symbol])
    end

    it 'returns a new array with all elements converted to integrs' do
      expect(%w[1 2 3 4 5].my_map(&:to_i)).to eql([1, 2, 3, 4, 5])
    end
  end

  describe '#my_inject' do
    it 'Returns local jump error if no block given' do
      expect { (1..4).my_inject }.to raise_error(LocalJumpError)
    end

    it 'Returns value of applying an operation to all numbers within range' do
      expect((1..4).my_inject(:+)).to eql(10)
    end

    it 'Returns multiple of array' do
      expect([1, 2, 3].my_inject(:*)).to eql(6)
    end
    it 'Returns integer after subtracting each element in array from previous element' do
      expect([1, 2, 3].my_inject(:-)).to eql(-4)
    end
    it 'Returns integer after dividing each element in array by next element' do
      expect([12, 3, 2].my_inject(:/)).to eql(2)
    end

    it 'Returns sum of numbers in a range' do
      expect((4..9).my_inject { |sum, n| sum + n }).to eql(39)
    end

    it 'Returns product of numbers in a range' do
      expect((5..10).my_inject(1) { |product, n| product * n }).to eql(151_200)
    end

    it 'Returns the longest word in a given block' do
      expect(%w[olaoluwa is tired].my_inject { |a, word| a.length > word.length ? a : word }).to eql('olaoluwa')
    end
  end

  describe '#multiply_else' do
    it 'Returns result from multiply_els method' do
      expect(multiply_els(1..4)).to eq(24)
    end
  end
end
