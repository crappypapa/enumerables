module Enumerable
  def my_each
    index = 0
    while index < length
      yield(self[index])
      index += 1
    end
    self
  end
  # [1,3,5,7].my_each{|number| p number}

  def my_each_with_index
    index = 0
    my_each do |item|
      yield(item, index)
      index += 1
    end
    self
  end
  # ["a","b","c","d"].my_each_with_index{|item,index| p "#{item} ,#{index}"}

  def my_select
    arr = []
    my_each do |item|
      arr << item if yield(item)
    end
    arr
  end
  # p [1,2,3,4,5].my_select { |num|  num % 2 == 0 }
  # p [:foo, :bar].my_select { |x| x == :foo }

  # rubocop:Style/Cese
  def my_all?(param = nil, &block)
    return true if length.zero? # return true if empty array given

    if param
      case param
      when Regexp
        return my_select { |el| el =~ param }.length == to_a.length
      when Class
        return my_select { |el| el.is_a?(param) }.length == to_a.length
      end
    end
    return my_select(&block).length == to_a.length if block_given?

    if !param && !block_given?
      class_type = self[0].class
      my_select { |el| el.instance_of?(class_type) }.length == to_a.length
    end
  end
  # p %w[ant bear cat].my_all?(/t/)
  # p [1, 2i, 3.14].my_all?(Numeric)
  # p %w[ant bear cat].all? { |word| word.length >= 3 }
  # p [nil, true, 99].all?

  # rubocop:Style/Cese
  def my_any?(param = nil)
    if param # If there is parameter given
      case param
      when Regexp # check if Regex class passed as 'parameter'
        my_each { |el| return true if el =~ param } # if at least one regex is matched return true
      when Class
        my_each do |el|
          if el.is_a?(param) # if at least one element class is matched with Class given via param
            return true # return true
          end
        end
      end
      return false # if my_each ends without finding given class in any el return false
    end
    if block_given?
      my_each do |el|
        return true if yield(el)
      end
      return false
    end
    my_each { |el| return true if !el.nil? || el != false } if !param && !block_given?
  end
  # p %w[ant bedar cat].my_any?(/d/)
  # p [nil, true, 99].my_any?(Integer)
  # p %w[ant bear cat].my_any? { |word| word.length >= 4 }
  p [nil, true, false].any?

  def my_none?(param = nil)
    return true if length.zero?

    if param
      case param
      when Regexp
        my_select { |item| item !~ param }.length == to_a.length
      when Class
        my_select { |item| !item.is_a? param }.length == to_a.length
      end
    end
    return my_select { |item| !yield(item) }.length == to_a.length if block_given?

    my_select(&:!).length == to_a.length if !param && !block_given?
  end

  def my_count(param = nil, &block)
    return my_select { |item| item == param }.length if param

    my_select(&block).length if block_given?
  end
  # p [1, 2, 4,2,4,5,6,2, 2].my_count(2)
  # p [1, 2, 4,2,4,5,6,2, 2].my_count{ |x| x%2==0 }

  def my_map(proc = nil)
    arr = []
    if block_given?
      to_a.my_each { |el| arr << yield(el) }
    elsif proc
      to_a.my_each { |el| arr << proc.call(el) }
    end
    arr
  end

  # p (1..4).map { |i| i*i }      #=> [1, 4, 9, 16]
  # p (1..4).collect { "cat"  }   #=> ["cat", "cat", "cat", "cat"]
  test_proc = proc { |x| x**2 }
  # p [2, 3, 4].my_map(test_proc)

  def my_inject(param1 = nil, param2 = nil)
    if param1 && !param2 && !block_given?
      if param1.is_a?(Symbol) || param1.is_a?(String)
        self_arr = to_a
        memo = self_arr[0]
        case param1
        when :+, '+'
          self_arr[1..-1].my_each { |el| memo += el }
        when :*, '*'
          self_arr[1..-1].my_each { |el| memo *= el }
        when :-, '-'
          self_arr[1..-1].my_each { |el| memo -= el }
        when :/, '/'
          self_arr[1..-1].my_each { |el| memo /= el }
        when :**, '**'
          self_arr[1..-1].my_each { |el| memo **= el }
        end
        memo
      end
    elsif param1 && param2 && !block_given?
      self_arr = to_a
      memo = param1
      case param2
      when :+, '+'
        self_arr.my_each { |el| memo += el }
      when :*, '*'
        self_arr.my_each { |el| memo *= el }
      when :-, '-'
        self_arr.my_each { |el| memo -= el }
      when :/, '/'
        self_arr.my_each { |el| memo /= el }
      when :**, '**'
        self_arr.my_each { |el| memo **= el }
      end
      memo
    end
    if block_given? && param1
      self_arr = to_a
      self_arr.my_each do |el|
        memo = memo.nil? ? yield(param1, el) : yield(memo, el)
      end
      memo
    elsif block_given? && !param1
      self_arr = to_a
      memo = param1
      self_arr.my_each { |el| memo = memo.nil? ? el : yield(memo, el) }
    end
    memo
  end

  # p (5..10).my_inject(:**)
  # p (5..10).my_inject('+')
  # p (5..10).my_inject(1, :+)
  # p (5..10).my_inject{ |product, n| product + n }
end

def multiply_els(arr)
  arr.my_inject(:*)
end
# multiply_els([2,4,5])
